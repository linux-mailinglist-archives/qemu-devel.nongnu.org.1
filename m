Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95AB1804AF9
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 08:16:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAPeA-0007gv-Rx; Tue, 05 Dec 2023 02:15:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1rAPe6-0007fx-KN
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 02:15:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1rAPe4-0002XQ-On
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 02:15:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701760502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sL2mQwYQomeKZCmAYIRkF9VCDBpAP9maQ6ksfUJSQgI=;
 b=HSv1WpIvcc84/3lpLxGFjuC/kIvnGCt5Df2f/UxWLzDEJEmXbiMY5nDemsL224/jI6veUK
 G7Y/yoD+DOFcm4HaDWRIq97gYeceJKaaTbY+1oJEcE6T/ID/nKUjMBWyNQGlud4LdV3Tue
 8FWDJ5QTLVcXDqEPEPqd1AmpQUpOXZ0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-iO1DGG0YO-WVO6cRBbJeJg-1; Tue, 05 Dec 2023 02:15:00 -0500
X-MC-Unique: iO1DGG0YO-WVO6cRBbJeJg-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-54c7be1e466so3569981a12.0
 for <qemu-devel@nongnu.org>; Mon, 04 Dec 2023 23:15:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701760498; x=1702365298;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sL2mQwYQomeKZCmAYIRkF9VCDBpAP9maQ6ksfUJSQgI=;
 b=hoKI7MFkzdIKKF80cBKQXL+pUJ6HU4rYF/f5o1Wvbt663k/C/P7TUUglMgol6N9Sbl
 upJdNPbcn6JFEdShSxKgGVtr8aATEbPDWj94wJda12WYOxixabgz8tSqMOQb+GwuOr6i
 +5Fa8+Armh52tsV4JdByo04O1EoCFvYynFIr7+spwYYsJa+YoDPwfiMzx0f/X6uBHLVF
 MBwWlkKlERsKeIhwprqpTHAnf8Yg5KWJ+R+Cb9cJcR04SP1KOG8wOA6QN8osXi5pxmgY
 ovqQYRvAy5VzFCKy4ld76v6MQ7EYCd6YpAGKVb2xRBhNQVjbLC04YHxEjWGg62L79406
 KohA==
X-Gm-Message-State: AOJu0Yy3gZU84SKat5ITnjJsNKHfk8Q35cVsRgVa3Nk4NHlzzkTimSNm
 c1+zbhILcpTMMsaVGIehF5mYM6SAyziAXYr8OY0L6I3r1x5nFIG3/CUrtuD3hB4oT7DQI64Jp7H
 aL/ifsGvi+FX4iN24l5Ftl0Aw5aALmAO8ZcKwXbs=
X-Received: by 2002:a50:d7d5:0:b0:54c:b72b:93 with SMTP id
 m21-20020a50d7d5000000b0054cb72b0093mr1049240edj.25.1701760498401; 
 Mon, 04 Dec 2023 23:14:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFn4Bv6jAqTakMSneKyb/Gv+U5KIIBK6W/TK6H2f5NN0VlQO6r8ngLCx9YDYUVhP+g0X7HoDd0AU+Mw5CmHhZU=
X-Received: by 2002:a50:d7d5:0:b0:54c:b72b:93 with SMTP id
 m21-20020a50d7d5000000b0054cb72b0093mr1049230edj.25.1701760498057; 
 Mon, 04 Dec 2023 23:14:58 -0800 (PST)
MIME-Version: 1.0
References: <20231204184051.16873-1-dongwon.kim@intel.com>
In-Reply-To: <20231204184051.16873-1-dongwon.kim@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 5 Dec 2023 11:14:46 +0400
Message-ID: <CAMxuvaxQc0EM0jPDTgmK+hM9EMjqrY696RzS4NWengbdC5ifpg@mail.gmail.com>
Subject: Re: [PATCH] ui/gtk: flush display pipeline before saving vmstate when
 blob=true
To: Dongwon Kim <dongwon.kim@intel.com>
Cc: qemu-devel@nongnu.org, Vivek Kasireddy <vivek.kasireddy@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi

On Tue, Dec 5, 2023 at 6:40=E2=80=AFAM Dongwon Kim <dongwon.kim@intel.com> =
wrote:
>
> If the guest state is paused before it gets a response for the current
> scanout frame submission (resource-flush), it won't start submitting
> new frames after being restored as it still waits for the old response,
> which is accepted as a scanout render done signal. So it's needed to
> unblock the current scanout render pipeline before the run state is
> changed to make sure the guest receives the response for the current
> frame submission.
>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
> ---
>  ui/gtk.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/ui/gtk.c b/ui/gtk.c
> index 810d7fc796..0f6237dd2f 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -678,6 +678,18 @@ static const DisplayGLCtxOps egl_ctx_ops =3D {
>  static void gd_change_runstate(void *opaque, bool running, RunState stat=
e)
>  {
>      GtkDisplayState *s =3D opaque;
> +    int i;
> +
> +    if (state =3D=3D RUN_STATE_SAVE_VM) {
> +        for (i =3D 0; i < s->nb_vcs; i++) {
> +            VirtualConsole *vc =3D &s->vc[i];
> +
> +            if (vc->gfx.guest_fb.dmabuf) {

&& ..dmabuf->fence_fd >=3D 0

> +                /* force flushing current scanout blob rendering process=
 */
> +                gd_hw_gl_flushed(vc);

This defeats the purpose of the fence, maybe we should wait for it to
be signaled first. At worse, I suppose the client can have some
glitches. Although since the guest is stopped, this is unlikely.


