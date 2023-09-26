Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE307AF587
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 22:49:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlExx-0002sX-0Z; Tue, 26 Sep 2023 16:47:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qlExf-0002qS-8w
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 16:47:20 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qlExc-0004TX-5g
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 16:47:15 -0400
Received: from mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:5429:0:640:6285:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id 8C3515FF95;
 Tue, 26 Sep 2023 23:47:07 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b41d::1:39] (unknown
 [2a02:6b8:b081:b41d::1:39])
 by mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 6lWbOr0OjuQ0-FYNiGNx2; Tue, 26 Sep 2023 23:47:06 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1695761226;
 bh=wXD8sxtnHzqhaMP0yKgHrs/mTcVYfbMVlCUNvKAjMbA=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=jHBbGPP0/lUJ+ZJwpSivXxZZZM/pkLoXuPLP5hA5NO4HHbjijIk9S7PWa7rRT4tgD
 bOf0g1r+R4kiGU8ycz6OD8cliEq259MM+ApRhLFPVnkMvFDL6VQI7MXqRSOSGXtbg1
 Isk0hcYyA/YWETwtcEpBzZbd5PxqLk/+kH5aEpt0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <d705b54e-b584-e14f-2046-7c27c131cde9@yandex-team.ru>
Date: Tue, 26 Sep 2023 23:47:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 5/8] pcie_sriov: unregister_vfs(): fix error path
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org, yc-core@yandex-team.ru,
 davydov-max@yandex-team.ru, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20230926201532.221152-1-vsementsov@yandex-team.ru>
 <20230926201532.221152-6-vsementsov@yandex-team.ru>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20230926201532.221152-6-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

[add Markus]

On 26.09.23 23:15, Vladimir Sementsov-Ogievskiy wrote:
> local_err must be NULL before calling object_property_set_bool(), so we
> must clear it on each iteration. Let's also use more convenient
> error_reportf_err().
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>   hw/pci/pcie_sriov.c | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
> index 76a3b6917e..5ef8950940 100644
> --- a/hw/pci/pcie_sriov.c
> +++ b/hw/pci/pcie_sriov.c
> @@ -196,19 +196,16 @@ static void register_vfs(PCIDevice *dev)
>   
>   static void unregister_vfs(PCIDevice *dev)
>   {
> -    Error *local_err = NULL;
>       uint16_t num_vfs = dev->exp.sriov_pf.num_vfs;
>       uint16_t i;
>   
>       trace_sriov_unregister_vfs(dev->name, PCI_SLOT(dev->devfn),
>                                  PCI_FUNC(dev->devfn), num_vfs);
>       for (i = 0; i < num_vfs; i++) {
> +        Error *err = NULL;
>           PCIDevice *vf = dev->exp.sriov_pf.vf[i];
> -        object_property_set_bool(OBJECT(vf), "realized", false, &local_err);
> -        if (local_err) {
> -            fprintf(stderr, "Failed to unplug: %s\n",
> -                    error_get_pretty(local_err));
> -            error_free(local_err);
> +        if (!object_property_set_bool(OBJECT(vf), "realized", false, &err)) {
> +            error_reportf_err(err, "Failed to unplug: ");
>           }
>           object_unparent(OBJECT(vf));
>           object_unref(OBJECT(vf));

-- 
Best regards,
Vladimir


