Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA7578EF56
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 16:11:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbiNb-00060X-OG; Thu, 31 Aug 2023 10:10:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1qbiNS-0005wa-Ix
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 10:10:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1qbiNP-0001e4-QU
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 10:10:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693491026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q8u1gO7jaENPAD2rwOXB/XMoOm0Klf+Sv2GNVqT/At0=;
 b=eK6WrDtYDhEz24HL7EZfINJfRs9u9iMrBku5kVLNGbn3YpqUS8p/Jj6plqwnVPUXDd5WKV
 9MxqFdmPng2kMrfQdrmhcbBpLpW+GE6eymRsXqpk0L9Vu1+BV3hWLE492+ZR4zm4uBRVKo
 pfi2SrIBTu2s1lS6I/qgvmmD3d3OK2Y=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-r7aNRq1YMbmRFZbu2FDlmw-1; Thu, 31 Aug 2023 10:10:24 -0400
X-MC-Unique: r7aNRq1YMbmRFZbu2FDlmw-1
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-573325a9d49so1004706eaf.1
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 07:10:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693491022; x=1694095822;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q8u1gO7jaENPAD2rwOXB/XMoOm0Klf+Sv2GNVqT/At0=;
 b=RJ8kCZJ5KBTm4L8YIgLtr9KqWTjF1ASA/mSMvZkMUneDD6/D8fI9SWyFVdxYCK2qdq
 lk1GUBvhpLYSyQfq4AnzvpfhH4UHKWooNETXEXAsTB9vWCQkxABJVpOZup+8Fl2Pvy8l
 20P126eWmUKeZz82Uw/UH5Pl4RijpbRy9tfR7xnJUcBDwXNkU8pvSooh8CKM4Wqtgjbh
 inoEzcvktOZrQN20ys+s0+uAuClSESTw4ni8jvQwDKlkJI6v3GTEp1gYVPdcTw6Yn+n+
 JpDUFkERnReclCdfx5gatLoZU+hqitVaCXEysiYPM+CjUIAMbqJcIsLquDB+cjz5i+8A
 BHdg==
X-Gm-Message-State: AOJu0YyIm1wkT5UWD+4bHbz3FivwJGoZzh8U+Xs75Qc5J2FEi9L1ClR7
 L45+QepqZrn1aEc5xsugVMElUkgQdOfw9I1xewfAEj4B8rfhE4tDtSFzhnq+dq51zQVcxkB+xQ/
 iQuL6iT0Nom76PTmf7RQeKtyAup+HBEs=
X-Received: by 2002:a05:6358:9986:b0:132:dc58:b372 with SMTP id
 j6-20020a056358998600b00132dc58b372mr3904211rwb.19.1693491022466; 
 Thu, 31 Aug 2023 07:10:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHw+quw3TJ0eGH8qDyzvYfHIts9+Z2hCWAe0mAsn9TBgMEkq4gcDsvE3Ke6tTw8eq/Q+91pXbKuldN9jFuN/7I=
X-Received: by 2002:a05:6358:9986:b0:132:dc58:b372 with SMTP id
 j6-20020a056358998600b00132dc58b372mr3904195rwb.19.1693491022140; Thu, 31 Aug
 2023 07:10:22 -0700 (PDT)
MIME-Version: 1.0
References: <158154486735.14935.3370403781300872079.malonedeb@soybean.canonical.com>
 <169348611423.1472917.10027704436078423318.malone@juju-98d295-prod-launchpad-3>
 <cb2807f0-fc7d-fc03-376e-09c3d5f10a7f@linaro.org>
 <ZPCcRD/zv/l80WWC@redhat.com>
In-Reply-To: <ZPCcRD/zv/l80WWC@redhat.com>
From: Mauro Matteo Cascella <mcascell@redhat.com>
Date: Thu, 31 Aug 2023 16:10:11 +0200
Message-ID: <CAA8xKjXNFVtzoYaVYz_apW2i3Qbvs0XC4JBS5EG7q_qPTOiAAw@mail.gmail.com>
Subject: Re: [Bug 1863025] Re: Use-after-free after flush in TCG accelerator
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Bug 1863025 <1863025@bugs.launchpad.net>, qemu-devel@nongnu.org, 
 Michael Tokarev <mjt@tls.msk.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mcascell@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Aug 31, 2023 at 3:57=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Thu, Aug 31, 2023 at 03:40:25PM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
> > Hi Samuel,
> >
> > On 31/8/23 14:48, Samuel Henrique wrote:
> > > CVE-2020-24165 was assigned to this:
> > > https://nvd.nist.gov/vuln/detail/CVE-2020-24165
> > >
> > > I had no involvement in the assignment, posting here for reference on=
ly.
> > >
> > > ** CVE added: https://cve.mitre.org/cgi-bin/cvename.cgi?name=3D2020-2=
4165
> >
> > QEMU 4.2.0 was released in 2019. The issue you report
> > has been fixed in commit 886cc68943 ("accel/tcg: fix race
> > in cpu_exec_step_atomic (bug 1863025)") which is included
> > in QEMU v5.0, released in April 2020, more than 3 years ago.
> >
> > What do you expect us to do here? I'm not sure whether assigning
> > CVE for 3 years old code is a good use of engineering time.
>
> In any case per our stated security policy, we do not consider TCG to
> be providing a security boundary between host and guest, and thus bugs
> in TCG aren't considered security flaws:
>
>  https://www.qemu.org/docs/master/system/security.html#non-virtualization=
-use-case

Right, and it is clearly indicated in the referenced launchpad bug:
'The security list informed me "This can not be treated as a security
issue"'.

This adds up to CVE-2022-36648, which is also a mystery to me in terms
of CVE assignment and CVSS scoring (rated as Critical). I don't know
what's going on with NVD, there must be something wrong on their side.

I disputed both CVEs via https://cveform.mitre.org/.

> With regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>

--=20
Mauro Matteo Cascella
Red Hat Product Security
PGP-Key ID: BB3410B0


