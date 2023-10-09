Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC107BD423
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 09:17:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpkUl-0007V0-Eq; Mon, 09 Oct 2023 03:16:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qpkUM-0007TV-W4
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 03:15:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qpkUL-0003Al-CC
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 03:15:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696835735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Ls3zROMLBeszrlBVEFp0I2mJMsy97mv2YMraMCcQCw=;
 b=Be/1zt0pFWyIOOaGca5WkmKoVrG5Ghv/UvrpU67ZiIZRv+hW2SD46jWYcGusSEy+mrqU5j
 a9B3PxylTZucoVA35f5LXeo3kRdfXwgV5D387x+o2XkVQUXPrafbXVCelv2+y1+rYCSrkV
 c6GaInhwivw9+yhW9t/rXQ/va9jRlSs=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-2LkQRXd5NOiLtBYjSdmq4A-1; Mon, 09 Oct 2023 03:15:34 -0400
X-MC-Unique: 2LkQRXd5NOiLtBYjSdmq4A-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-538128e18e9so3381886a12.2
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 00:15:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696835733; x=1697440533;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2Ls3zROMLBeszrlBVEFp0I2mJMsy97mv2YMraMCcQCw=;
 b=AwVKAJESjbZmnG3H7vZSrxQDKLWKpDeUSQ8VKCbn+aSP0/XIhqSUC50bxPnGwlhUF6
 a0pt5u8Su2jv3wXmkQWBUhInU3fzcpEesjFN/o6rfv/mDpH4vffjX1e4YhwABNhhFHG3
 U6Fx3clLsYjUFERG5FmO5FsT58PpkIiAStN6Hoi5xO3GVd/v8YOp9ACsKLksUpzYa9Nf
 Pdh8VDKihq7qC4j4yFCWAaPVf6N9SP/YRsMmyaZzxMox97viuuPZrbeCFQjSsPcI2fRa
 lzbpaSJcmPTkhoF1qruKh0iTP2rOBB+7f/nrmPTdAXWq6RcZdxcXr8wTQlDt6g97OBix
 FAeg==
X-Gm-Message-State: AOJu0YzouEOcxwFq7IjWRjdVPP1je7+wi3epd1v/DDrES7p9ftlGbNC8
 JIHjwI/VxREahxASUE+AOIx9seuCa7zn9wH8Ke++0WJKpm94AqJQP3Y8Ns1xUFIJgOnJpW+pq0q
 FaMCs5qrtBdW5wSPWfgl3G8zaBvd+ux4=
X-Received: by 2002:a05:6402:344a:b0:523:4025:49f0 with SMTP id
 l10-20020a056402344a00b00523402549f0mr12406683edc.26.1696835733126; 
 Mon, 09 Oct 2023 00:15:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcb8Iw32/hto1cxkwZxHjOQdnh3Oknw3gCxilLZz5D8QXgmCtneMZcR2mW4IjPgdEoNczGx9bVSznmAA2Z70Q=
X-Received: by 2002:a05:6402:344a:b0:523:4025:49f0 with SMTP id
 l10-20020a056402344a00b00523402549f0mr12406668edc.26.1696835732845; Mon, 09
 Oct 2023 00:15:32 -0700 (PDT)
MIME-Version: 1.0
References: <20231006010835.444-1-gurchetansingh@chromium.org>
In-Reply-To: <20231006010835.444-1-gurchetansingh@chromium.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 9 Oct 2023 11:15:21 +0400
Message-ID: <CAMxuvay04ZF7awEG0Hv9mhPvUTnjMmQ+TL4a=hMEkFwrgcR5Vw@mail.gmail.com>
Subject: Re: [PATCH v17 0/9] gfxstream + rutabaga_gfx
To: Gurchetan Singh <gurchetansingh@chromium.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, akihiko.odaki@gmail.com, ray.huang@amd.com, 
 alex.bennee@linaro.org, shentey@gmail.com, hi@alyssa.is, ernunes@redhat.com, 
 manos.pitsidianakis@linaro.org, mark.cave-ayland@ilande.co.uk, 
 thuth@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Hi

On Fri, Oct 6, 2023 at 5:08=E2=80=AFAM Gurchetan Singh
<gurchetansingh@chromium.org> wrote:
>
> From: Gurchetan Singh <gurchetansingh@google.com>
>
> Branch containing changes:
>
> https://gitlab.com/gurchetansingh/qemu/-/commits/qemu-gfxstream-v17
>
> Changes since v16:
>
> - Fixed typo mentioned here:
>
> https://lists.gnu.org/archive/html/qemu-devel/2023-10/msg01407.html
>
> Antonio Caggiano (2):
>   virtio-gpu: CONTEXT_INIT feature
>   virtio-gpu: blob prep
>
> Dr. David Alan Gilbert (1):
>   virtio: Add shared memory capability
>
> Gerd Hoffmann (1):
>   virtio-gpu: hostmem
>
> Gurchetan Singh (5):
>   gfxstream + rutabaga prep: added need defintions, fields, and options
>   gfxstream + rutabaga: add initial support for gfxstream
>   gfxstream + rutabaga: meson support
>   gfxstream + rutabaga: enable rutabaga
>   docs/system: add basic virtio-gpu documentation
>

Except for a few misc style issues, the series looks good to me.

Gerd, as the virtio-gpu "odd fixes" maintainer, any chance you take a
quick look and ack the series? Even better if you send a PR :)

thanks


