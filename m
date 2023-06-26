Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 282F173E403
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 17:54:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDoWm-00015x-A9; Mon, 26 Jun 2023 11:53:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qDoWZ-00015Y-IQ
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 11:53:08 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qDoWX-0005uY-Ht
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 11:53:07 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2E608EE9F;
 Mon, 26 Jun 2023 18:53:03 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id EBEB0F750;
 Mon, 26 Jun 2023 18:53:01 +0300 (MSK)
Message-ID: <bd539426-a69c-9cbc-5f24-4fbe5a236fd6@tls.msk.ru>
Date: Mon, 26 Jun 2023 18:53:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PULL 53/53] vhost-vdpa: do not cleanup the vdpa/vhost-net
 structures if peer nic is present
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Ani Sinha
 <anisinha@redhat.com>, imammedo@redhat.com, jusual@redhat.com,
 Jason Wang <jasowang@redhat.com>
References: <cover.1687782442.git.mst@redhat.com>
 <3d90d47995b83bd1edf6e756c00e74fd5ec16aee.1687782442.git.mst@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <3d90d47995b83bd1edf6e756c00e74fd5ec16aee.1687782442.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

26.06.2023 15:30, Michael S. Tsirkin wrote:
> From: Ani Sinha <anisinha@redhat.com>
> 
> When a peer nic is still attached to the vdpa backend, it is too early to free
> up the vhost-net and vdpa structures. If these structures are freed here, then
> QEMU crashes when the guest is being shut down. The following call chain
> would result in an assertion failure since the pointer returned from
> vhost_vdpa_get_vhost_net() would be NULL:
> 
> do_vm_stop() -> vm_state_notify() -> virtio_set_status() ->
> virtio_net_vhost_status() -> get_vhost_net().
> 
> Therefore, we defer freeing up the structures until at guest shutdown
> time when qemu_cleanup() calls net_cleanup() which then calls
> qemu_del_net_client() which would eventually call vhost_vdpa_cleanup()
> again to free up the structures. This time, the loop in net_cleanup()
> ensures that vhost_vdpa_cleanup() will be called one last time when
> all the peer nics are detached and freed.
> 
> All unit tests pass with this change.
> 
> CC: imammedo@redhat.com
> CC: jusual@redhat.com
> CC: mst@redhat.com
> Fixes: CVE-2023-3301
> Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=2128929
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> Message-Id: <20230619065209.442185-1-anisinha@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   net/vhost-vdpa.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 9e92b3558c..e19ab063fa 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -207,6 +207,14 @@ static void vhost_vdpa_cleanup(NetClientState *nc)
>   {
>       VhostVDPAState *s = DO_UPCAST(VhostVDPAState, nc, nc);
>   
> +    /*
> +     * If a peer NIC is attached, do not cleanup anything.
> +     * Cleanup will happen as a part of qemu_cleanup() -> net_cleanup()
> +     * when the guest is shutting down.
> +     */
> +    if (nc->peer && nc->peer->info->type == NET_CLIENT_DRIVER_NIC) {
> +        return;
> +    }
>       munmap(s->cvq_cmd_out_buffer, vhost_vdpa_net_cvq_cmd_page_len());
>       munmap(s->status, vhost_vdpa_net_cvq_cmd_page_len());
>       if (s->vhost_net) {


Given the CVE# attached, is it a -stable material?
The same change can be applied to 8.0 and even to 7.2, with slight difference
in context (using qemu_vfree() instead of munmap() for cvq_cmd_out_buffer etc).
The original bugreport is about qemu 7.1.

Thanks,

/mjt

