Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E52802D10
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 09:21:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rA4CV-0006lL-Vw; Mon, 04 Dec 2023 03:21:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rA4CO-0006kp-RU
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 03:21:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rA4CM-0000WL-Qe
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 03:21:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701678061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pTO86TCuL1UlS79sTHit9l55mFHn8DMRvVTJs0BXuBk=;
 b=GlIwHtcTDbIc+8ClBSEah32TSBO0Ujqce38VFMPQqv4dX19JsMMxm4oBZkH0+jNtE2Ft3j
 7970UdcBnJUdPGgly4wrp8qistHe7qo2BrpkRb+9C3N/U92ZMgOHs+1mcnXuKSUbbChv+0
 MV2enGr1cNMonB51Oa3dcbn7xOmvGf0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-GRYoxPWyMMCmFbykIm5yiQ-1; Mon, 04 Dec 2023 03:20:58 -0500
X-MC-Unique: GRYoxPWyMMCmFbykIm5yiQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-332d213c2bbso3113193f8f.1
 for <qemu-devel@nongnu.org>; Mon, 04 Dec 2023 00:20:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701678057; x=1702282857;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pTO86TCuL1UlS79sTHit9l55mFHn8DMRvVTJs0BXuBk=;
 b=jRAC27UFHqanFzvKYmmuTSIjqtIMxND9ahUhHMEXBuCb0hKfB6NxpcLzKm1BWsNi8B
 a1bggXI7C1QnliolqpjlO62u5aXlMWD2/UX0revLSp2gj8wpmCpmBYWG5SjVDoR8W6ra
 mZLMKUdcz04owSfsig3AjOdrm7gFnpwGOExae5y6h0HuuiScnSsmKSWhwnaTlf6CiMjh
 AWTAPC6L828+nZi0kxaPLBLKZkvWez11f2OY0baEJiY3wvMqRoCznPwTvP3fWjDs7BGT
 e81XEZdYS9OXIBIOZvTVNXZkSuL67a1hDUBbAO6rnL4RkyVcRczecE2XQ4TtULDEGVo9
 l+hA==
X-Gm-Message-State: AOJu0YwmNU0tIaI3MLVOPkdDHYy5Q9AMvP1j5RyWlmyDpC7Rjr1mY29q
 QtKpWR6IAkXj3ZtkZktneYwd6d70KhfXgB/L9HuV4oF0NkQ9zt0t+AsJXaKLymMOEQEBFrZNm85
 +NAr2Ppu4UREV2Ys=
X-Received: by 2002:a05:600c:28c:b0:40b:3dae:1ff6 with SMTP id
 12-20020a05600c028c00b0040b3dae1ff6mr2118800wmk.14.1701678057713; 
 Mon, 04 Dec 2023 00:20:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEf8hhX7V/TrPoraERuMM+xAqa/A1ymr74mNOgmOEoUDJ0rwfZKK+dE0Xd3iBOiPoJyE/qnCg==
X-Received: by 2002:a05:600c:28c:b0:40b:3dae:1ff6 with SMTP id
 12-20020a05600c028c00b0040b3dae1ff6mr2118796wmk.14.1701678057406; 
 Mon, 04 Dec 2023 00:20:57 -0800 (PST)
Received: from redhat.com ([2.55.11.133]) by smtp.gmail.com with ESMTPSA id
 f17-20020a05600c155100b004083729fc14sm17711374wmg.20.2023.12.04.00.20.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Dec 2023 00:20:56 -0800 (PST)
Date: Mon, 4 Dec 2023 03:20:53 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Volker =?iso-8859-1?Q?R=FCmelin?= <vr_qemu@t-online.de>
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH for 8.2] hw/audio/virtio-sound: mark the device as
 unmigratable
Message-ID: <20231204032047-mutt-send-email-mst@kernel.org>
References: <20231204072837.6058-1-vr_qemu@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231204072837.6058-1-vr_qemu@t-online.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Dec 04, 2023 at 08:28:37AM +0100, Volker Rümelin wrote:
> The virtio-sound device is currently not migratable. QEMU crashes
> on the source machine at some point during the migration with a
> segmentation fault.
> 
> Even with this bug fixed, the virtio-sound device doesn't migrate
> the state of the audio streams. For example, running streams leave
> the device on the destination machine in a broken condition.
> 
> Mark the device as unmigratable until these issues have been fixed.
> 
> Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  hw/audio/virtio-snd.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
> index 2fe966e311..b10fad1228 100644
> --- a/hw/audio/virtio-snd.c
> +++ b/hw/audio/virtio-snd.c
> @@ -68,6 +68,7 @@ static const VMStateDescription vmstate_virtio_snd_device = {
>  
>  static const VMStateDescription vmstate_virtio_snd = {
>      .name = TYPE_VIRTIO_SND,
> +    .unmigratable = 1,
>      .minimum_version_id = VIRTIO_SOUND_VM_VERSION,
>      .version_id = VIRTIO_SOUND_VM_VERSION,
>      .fields = (VMStateField[]) {
> -- 
> 2.35.3


