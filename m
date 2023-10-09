Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6BB7BE651
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 18:25:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpt41-00067Y-V9; Mon, 09 Oct 2023 12:25:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qpt40-00067M-DC
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 12:25:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qpt3y-0005FN-EJ
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 12:25:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696868697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d0q/Gr/oTxZt58a0GZqqkI78SsxEf8/h5cBCHpeUazA=;
 b=frjVBPaXXiU2xAVuCpuwdjL31wbSaD2euKHpI2fS531f3/vu2/BDHz3BqRpadtjed/X6yi
 KDwcGHynoZPu5KxAMuP5xIk2DkXJmJhKom1ojnH9ILdvqJ7CP4mNMRLTnVn3UOljCeHp4+
 zR9ETKWVpQSsAU+DX61s1RN3Jg2VxE8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-SdOd_KbuNWOw13dY8J5i4A-1; Mon, 09 Oct 2023 12:24:46 -0400
X-MC-Unique: SdOd_KbuNWOw13dY8J5i4A-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-94f7a2b21fdso353951066b.2
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 09:24:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696868685; x=1697473485;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d0q/Gr/oTxZt58a0GZqqkI78SsxEf8/h5cBCHpeUazA=;
 b=JJq5TGmYkWgK6E2MT/Oh6K16sAg8F3KR/El5k1fmc007FZMCLVw7JLmcnKhbDVtiB0
 SCpDGuqKdsDtDZl7YWyMUEuPioqiO/HaEg5/YCX2CX/NtpGEIcIIkmHzks0raBltA3AW
 sAu9x5K7tqji3KMvKsk3cCyeaOYF+LjTqwMrOTQs1XxGpaLblu08uk+RlaT/roSXRweJ
 00XpuU4JCLcZMZSOCL5MCQK1P2HUUteC1T7x2ZxWF+24BBVYBf0O7jqmAj4r+p5BibpV
 F4JL0FaqXEVryN8ue0fcKrP4DBNwl0D5Lu/r8QyMyxegKrZNhpfmllrH7TUQkVlDc9k4
 TirQ==
X-Gm-Message-State: AOJu0YxguHLnUfrG4/T00OflU6f8EaSY5UmRfU0OkuXiQGNPINZuDG51
 O4ARB1W32JcO9DZEfVXaCqDJEh441y8nvclruq2SmM8i3rOLRVe6916NGHr5tbgqzi5eoW1fi3I
 olRji5feDkcER0b4=
X-Received: by 2002:a17:907:270a:b0:9b2:b749:ff93 with SMTP id
 w10-20020a170907270a00b009b2b749ff93mr14560365ejk.24.1696868685247; 
 Mon, 09 Oct 2023 09:24:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUPRsGk4vQ7WLiechnSIwGMdfCRkrevCdsXxhsrOcT1kkxawxffCvIiwUtPjfDa/fWsO/ZtQ==
X-Received: by 2002:a17:907:270a:b0:9b2:b749:ff93 with SMTP id
 w10-20020a170907270a00b009b2b749ff93mr14560345ejk.24.1696868684918; 
 Mon, 09 Oct 2023 09:24:44 -0700 (PDT)
Received: from redhat.com ([2.55.57.209]) by smtp.gmail.com with ESMTPSA id
 x20-20020a170906299400b00997c1d125fasm7021961eje.170.2023.10.09.09.24.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Oct 2023 09:24:38 -0700 (PDT)
Date: Mon, 9 Oct 2023 12:24:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2] hw/virtio/virtio-gpu: Fix compiler warning when
 compiling with -Wshadow
Message-ID: <20231009122356-mutt-send-email-mst@kernel.org>
References: <20231009084559.41427-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231009084559.41427-1-thuth@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Oct 09, 2023 at 10:45:59AM +0200, Thomas Huth wrote:
> Avoid using trivial variable names in macros, otherwise we get
> the following compiler warning when compiling with -Wshadow=local:
> 
> In file included from ../../qemu/hw/display/virtio-gpu-virgl.c:19:
> ../../home/thuth/devel/qemu/hw/display/virtio-gpu-virgl.c:
>  In function ‘virgl_cmd_submit_3d’:
> ../../qemu/include/hw/virtio/virtio-gpu.h:228:16: error: declaration of ‘s’
>  shadows a previous local [-Werror=shadow=compatible-local]
>   228 |         size_t s;
>       |                ^
> ../../qemu/hw/display/virtio-gpu-virgl.c:215:5: note: in expansion of macro
>  ‘VIRTIO_GPU_FILL_CMD’
>   215 |     VIRTIO_GPU_FILL_CMD(cs);
>       |     ^~~~~~~~~~~~~~~~~~~
> ../../qemu/hw/display/virtio-gpu-virgl.c:213:12: note: shadowed declaration
>  is here
>   213 |     size_t s;
>       |            ^
> cc1: all warnings being treated as errors
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2: Renamed the variable to something even less trivial
> 
>  include/hw/virtio/virtio-gpu.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Apropos why is this header not in include/hw/display/

> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
> index 390c4642b8..4739fa4689 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -225,13 +225,13 @@ struct VhostUserGPU {
>  };
>  
>  #define VIRTIO_GPU_FILL_CMD(out) do {                                   \
> -        size_t s;                                                       \
> -        s = iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num, 0,          \
> +        size_t virtiogpufillcmd_s_ =                                    \
> +            iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num, 0,          \
>                         &out, sizeof(out));                              \
> -        if (s != sizeof(out)) {                                         \
> +        if (virtiogpufillcmd_s_ != sizeof(out)) {                       \
>              qemu_log_mask(LOG_GUEST_ERROR,                              \
>                            "%s: command size incorrect %zu vs %zu\n",    \
> -                          __func__, s, sizeof(out));                    \
> +                          __func__, virtiogpufillcmd_s_, sizeof(out));  \
>              return;                                                     \
>          }                                                               \
>      } while (0)
> -- 
> 2.41.0


