Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 79142806BEA
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Dec 2023 11:28:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAp7r-0006G5-C1; Wed, 06 Dec 2023 05:27:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <casantos@redhat.com>)
 id 1rAp7p-0006Fi-5i
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 05:27:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <casantos@redhat.com>)
 id 1rAp7n-0006xA-AU
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 05:27:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701858444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ik0sT8ye2FBvhBYVnvhMEyxxJaRtPTNqO+d0WeH4eEE=;
 b=BM+VyfoHoGLoy/f189iVievUbCpMCbJ0Qp5odR6HogTJzKlkuwHxRsp7JIH6zdSfpAt0zf
 9Tl1T6kKwB6+9YWf7iw4Tki/5Mr1MUuw8SUU5eHMmPtfy2YeZpnYbgw20oQ25pZ2S3DO3E
 CKHnVznuTt8db8lo5ONYV2HhLAmCQRE=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-PDj3Rmh2NMGLBXwkyVRFLQ-1; Wed, 06 Dec 2023 05:26:18 -0500
X-MC-Unique: PDj3Rmh2NMGLBXwkyVRFLQ-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-50becd7229aso3585429e87.3
 for <qemu-devel@nongnu.org>; Wed, 06 Dec 2023 02:26:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701858373; x=1702463173;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ik0sT8ye2FBvhBYVnvhMEyxxJaRtPTNqO+d0WeH4eEE=;
 b=VX0bVGCNDrIvvDnBoDZOXDx+Iv4Mydy7mca+ljwktA3JQ+ne/5UUC/OzfP0ps3sZWn
 8T3hpxXHdGAfhRwDDGiA7O2i83i9EG8jJX2hkdJ0zTA5Pv/cIR1MfbRx+vra+7nH1lGc
 uqyCgAaRpy1QvdeqZ3a2GYgj++0C9R6rkYXnQAFrHdIBNkattxXksOJPDKPtwUpWdhU/
 SxqjhmSygRc7anWgboFIpURwsOB44bvUhN640IlufWtPpHQ1BY4N0rYhRgywtUY7nj+b
 dUEUD+p7kUBMm0spa5S1MK5i2rZQuJQ2N53e7/KCD+TIPxx5dVFrPUTVU58gSmvJW0H2
 ADuw==
X-Gm-Message-State: AOJu0YwrvO46UUIra8KI+E2ejU/xcokCeMbt7nQK8lGkMiPTjGnnYVbY
 Lq7T579ypDB1XUJOdbOSPWG0vKc7ggv5kxzkT2OyObD/sHjzAumDo/m91BFWCUOJtg539ydPLYO
 IkirV0NUYQrIBFHb/q91KJrSau6Upa18=
X-Received: by 2002:ac2:5f8d:0:b0:50b:f553:81ba with SMTP id
 r13-20020ac25f8d000000b0050bf55381bamr353625lfe.9.1701858373047; 
 Wed, 06 Dec 2023 02:26:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG526lYnSiCxnFcggxENPqFP3O+Jii+dutxJBc2FPyRRLkp0LGZiMcNiJ79zm36w+K3hftLf3H/WUpKxZNmbeU=
X-Received: by 2002:ac2:5f8d:0:b0:50b:f553:81ba with SMTP id
 r13-20020ac25f8d000000b0050bf55381bamr353600lfe.9.1701858372764; Wed, 06 Dec
 2023 02:26:12 -0800 (PST)
MIME-Version: 1.0
References: <20230420120948.436661-1-stefanha@redhat.com>
 <20230420120948.436661-21-stefanha@redhat.com>
In-Reply-To: <20230420120948.436661-21-stefanha@redhat.com>
From: Carlos Santos <casantos@redhat.com>
Date: Wed, 6 Dec 2023 07:26:01 -0300
Message-ID: <CAC1VKkMadcEV4+UwXQQEONTBnw=xfmFC2MeUoruMRNkOLK0+qg@mail.gmail.com>
Subject: Re: [PULL 20/20] tracing: install trace events file only if necessary
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Raphael Norwitz <raphael.norwitz@nutanix.com>, 
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-block@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>, kvm@vger.kernel.org, 
 virtio-fs@redhat.com, Hanna Reitz <hreitz@redhat.com>,
 Fam Zheng <fam@euphon.net>, Aarushi Mehta <mehta.aaru20@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=casantos@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Thu, Apr 20, 2023 at 9:10=E2=80=AFAM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> From: Carlos Santos <casantos@redhat.com>
>
> It is not useful when configuring with --enable-trace-backends=3Dnop.
>
> Signed-off-by: Carlos Santos <casantos@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Message-Id: <20230408010410.281263-1-casantos@redhat.com>
> ---
>  trace/meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/trace/meson.build b/trace/meson.build
> index 8e80be895c..30b1d942eb 100644
> --- a/trace/meson.build
> +++ b/trace/meson.build
> @@ -64,7 +64,7 @@ trace_events_all =3D custom_target('trace-events-all',
>                                   input: trace_events_files,
>                                   command: [ 'cat', '@INPUT@' ],
>                                   capture: true,
> -                                 install: true,
> +                                 install: get_option('trace_backends') !=
=3D [ 'nop' ],
>                                   install_dir: qemu_datadir)
>
>  if 'ust' in get_option('trace_backends')
> --
> 2.39.2
>

Hello,

I still don't see this in the master branch. Is there something
preventing it from being applied?

--=20
Carlos Santos
Senior Software Maintenance Engineer
Red Hat
casantos@redhat.com    T: +55-11-3534-6186


