Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D95F27C87E4
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 16:32:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrJDH-0008Em-Ct; Fri, 13 Oct 2023 10:32:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qrJDF-0008E4-OG
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 10:32:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qrJDD-00009Y-Tc
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 10:32:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697207541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rh1LO2HXEhg9cECeidUgW9JnmNdFzjtwrPWyzGs+seY=;
 b=ioiuiWz6KPLBlEUujgEvDMoQUstSJtg1v+6mkR3/NxZkolzPijWuZZ1QBpBGusUbX7z/al
 b8U72ua6X4YOhzKceC5BWuDfNXSh31l1GS7mp3elz1iok/ueoeWSuDrhN4lKZwV47euQ1j
 CPcvH1UNrbCtpYfvj+RkN4W1WyKZWbI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-6xDaAyvjNp6msskcbCT5NA-1; Fri, 13 Oct 2023 10:32:14 -0400
X-MC-Unique: 6xDaAyvjNp6msskcbCT5NA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-40540179bcdso17424925e9.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 07:32:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697207533; x=1697812333;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rh1LO2HXEhg9cECeidUgW9JnmNdFzjtwrPWyzGs+seY=;
 b=sYxKWVmv929uLN6jt6sWkpsMWO7OCdM6Z72HRv9CJLIM6J5CklMwsT8tNrYjwJnUjr
 JWyoCm6Xp5lLCmFLLm1re6TeCluZrsokhg0uqZn7dqUQoVogkSEfoHGF8khNvOTr/16o
 f4dN44sToU6S0bQkFfyMmdMNv7ZvP9PwuXNJfLyJ1bSJavn8IKu1VV1PXa4cblWfm92v
 nl6nyD6hWieJtRjnfFuwtlqy/w7ja6v8Bc/0OdOL6UFj4WJI0CbzBDZSQSR9ss9IQrxI
 H9Bsywc02Nm0RBC7COwS2M6p89lb3rjTtYzka6GuFsCFJduYbH4RgT+3sjbwEoPhAF+F
 nqhQ==
X-Gm-Message-State: AOJu0Yx9or9Uj8DN1jykVkOoWUiPjKLo2NtLvZHb60KBmOM/7MPhb4Jt
 PmMB/4RIkT9aGyqbeEHMBkF9T6eldQYutyeTIwOPG8OAssplXWrLLDcrVuZasaMOCLgCkEGG5nZ
 /mBx/+M+CwHYrdQOJOcVugqT2Mg==
X-Received: by 2002:a7b:cb8c:0:b0:405:3f19:fc49 with SMTP id
 m12-20020a7bcb8c000000b004053f19fc49mr24234098wmi.34.1697207532983; 
 Fri, 13 Oct 2023 07:32:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAtH+EJGmIFrOb53DC4AXEK8MuDLM29etp0+qvbsTNISmuTJxA6tTAmx8OCRppciKWRkiluw==
X-Received: by 2002:a7b:cb8c:0:b0:405:3f19:fc49 with SMTP id
 m12-20020a7bcb8c000000b004053f19fc49mr24234080wmi.34.1697207532665; 
 Fri, 13 Oct 2023 07:32:12 -0700 (PDT)
Received: from redhat.com ([2a02:14f:175:cf7d:d542:c2ef:a65c:aaad])
 by smtp.gmail.com with ESMTPSA id
 g22-20020a05600c4c9600b0040536dcec17sm277036wmp.27.2023.10.13.07.32.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 07:32:12 -0700 (PDT)
Date: Fri, 13 Oct 2023 10:32:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>
Subject: Re: [PATCH v3 01/11] tap: Remove tap_probe_vnet_hdr_len()
Message-ID: <20231013103151-mutt-send-email-mst@kernel.org>
References: <20231011153944.39572-1-akihiko.odaki@daynix.com>
 <20231011153944.39572-2-akihiko.odaki@daynix.com>
 <CACGkMEt-kR5EVozeO+Zcx9kxdLLggBM8V98YUKQKutb28TvgCQ@mail.gmail.com>
 <74139826-7e06-48c0-bb1c-0b5bf708c808@daynix.com>
 <CACGkMEuEs2MLJYKMB9qAgT2ixkKLC8LPPE6DsBvfwx0CEaCA_A@mail.gmail.com>
 <12412f11-4395-460f-9523-930ad9270188@daynix.com>
 <20231013101508-mutt-send-email-mst@kernel.org>
 <29fef0dd-86b6-4cd6-bbbc-812b832d8fcf@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <29fef0dd-86b6-4cd6-bbbc-812b832d8fcf@daynix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Fri, Oct 13, 2023 at 11:22:10PM +0900, Akihiko Odaki wrote:
> On 2023/10/13 23:17, Michael S. Tsirkin wrote:
> > On Fri, Oct 13, 2023 at 02:26:03PM +0900, Akihiko Odaki wrote:
> > > On 2023/10/13 14:00, Jason Wang wrote:
> > > > On Fri, Oct 13, 2023 at 12:14 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
> > > > > 
> > > > > On 2023/10/13 10:38, Jason Wang wrote:
> > > > > > On Wed, Oct 11, 2023 at 11:40 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
> > > > > > > 
> > > > > > > It was necessary since an Linux older than 2.6.35 may implement the
> > > > > > > virtio-net header but may not allow to change its length. Remove it
> > > > > > > since such an old Linux is no longer supported.
> > > > > > 
> > > > > > Where can I see this agreement?
> > > > > 
> > > > > docs/about/build-platforms.rst says:
> > > > >    > The project aims to support the most recent major version at all times
> > > > >    > for up to five years after its initial release. Support for the
> > > > >    > previous major version will be dropped 2 years after the new major
> > > > >    > version is released or when the vendor itself drops support, whichever
> > > > >    > comes first. In this context, third-party efforts to extend the
> > > > >    > lifetime of a distro are not considered, even when they are endorsed
> > > > >    > by the vendor (eg. Debian LTS); the same is true of repositories that
> > > > >    > contain packages backported from later releases (e.g. Debian
> > > > >    > backports). Within each major release, only the most recent minor
> > > > >    > release is considered.
> > > > >    >
> > > > >    > For the purposes of identifying supported software versions available
> > > > >    > on Linux, the project will look at CentOS, Debian, Fedora, openSUSE,
> > > > >    > RHEL, SLES and Ubuntu LTS. Other distros will be assumed to ship
> > > > >    > similar software versions.
> > > > 
> > > > Well it also says:
> > > > 
> > > > """
> > > > If a platform is not listed here, it does not imply that QEMU won't
> > > > work. If an unlisted platform has comparable software versions to a
> > > > listed platform, there is every expectation that it will work.
> > > > """
> > > > 
> > > > A lot of downstream have customized build scripts.
> > > 
> > > Still Linux versions older than 2.6.35 do not look like "comparable software
> > > versions to a listed platform" in my opinion.
> > 
> > 
> > This is fine - I would be ok to replace support with an error message
> > and failure. Not checking that a capability is supported however
> > isn't a good idea. And once we do - do we still gain anything by
> > not working around that?
> 
> tap does still check if setting the header length succeeds so it should be
> fine.

It asserts though doesn't it? Hardly user friendly ...


