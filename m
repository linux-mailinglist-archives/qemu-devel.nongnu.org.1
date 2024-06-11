Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1EC903BFB
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jun 2024 14:33:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH0gh-0002Gz-CY; Tue, 11 Jun 2024 08:33:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>) id 1sH0gd-0002GV-N9
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 08:33:16 -0400
Received: from mx.swemel.ru ([95.143.211.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>) id 1sH0gc-00010C-0J
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 08:33:15 -0400
Message-ID: <a2a6e83e-fb47-4de1-a807-81843092c3fa@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
 t=1718109192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zu92SY8BigfsXSNFXgZf82QTZTbmbV8DEpbmgDtKA7Q=;
 b=G8ehK9ZYOt39PE29ue67NOQyo5OQX0JbvDj3BYnlLCMlfb+yHlox5lx075ygKPvMi5ue5k
 Z5DnijEsvdNSnTuIAOe7xRGbvU+Q9LuUkKMJXL93ewXon+f4+tVCJrEkl+33BBlRnYwvsv
 CSMxkp82uuWdB2qZVPTV8Edrch9Z0R0=
Date: Tue, 11 Jun 2024 15:33:12 +0300
MIME-Version: 1.0
Subject: Re: [PATCH] hw/net/virtio-net.c: fix crash in iov_copy()
Content-Language: en-US
To: mst@redhat.com
Cc: sdl.qemu@linuxtesting.org, qemu-devel@nongnu.org
References: <20240527133140.218300-2-frolov@swemel.ru>
From: =?UTF-8?B?0JTQvNC40YLRgNC40Lkg0KTRgNC+0LvQvtCy?= <frolov@swemel.ru>
In-Reply-To: <20240527133140.218300-2-frolov@swemel.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=95.143.211.150; envelope-from=frolov@swemel.ru;
 helo=mx.swemel.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

ping

https://patchew.org/QEMU/20240527133140.218300-2-frolov@swemel.ru/

On 27.05.2024 16:31, Dmitry Frolov wrote:
> A crash found while fuzzing device virtio-net-socket-check-used.
> Assertion "offset == 0" in iov_copy() fails if less than guest_hdr_len bytes
> were transmited.
>
> Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
> ---
>   hw/net/virtio-net.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 24e5e7d347..603b80a50a 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -2783,6 +2783,12 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *q)
>            */
>           assert(n->host_hdr_len <= n->guest_hdr_len);
>           if (n->host_hdr_len != n->guest_hdr_len) {
> +            if (iov_size(out_sg, out_num) < n->guest_hdr_len) {
> +                virtio_error(vdev, "virtio-net header is invalid");
> +                virtqueue_detach_element(q->tx_vq, elem, 0);
> +                g_free(elem);
> +                return -EINVAL;
> +            }
>               unsigned sg_num = iov_copy(sg, ARRAY_SIZE(sg),
>                                          out_sg, out_num,
>                                          0, n->host_hdr_len);


