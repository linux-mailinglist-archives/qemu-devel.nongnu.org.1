Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 971BC8300B7
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 08:47:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ0ck-0003zE-M4; Wed, 17 Jan 2024 02:46:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1rQ0ce-0003xK-OI
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 02:46:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1rQ0cc-0000CF-O9
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 02:46:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705477560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y2MLVnm8830qS1Mj7yohBJ2dzsWrUAAFEkJxGDrAOS4=;
 b=gcfwDG2PfXT0Fe3ZDCK3hQA6hGqPL/rS1pWN/6KbP9bF/p1/Y3khtKIOWSP+rBdclX7VP7
 IlYMrxrjmeww3xRx1wKKlO0oXfmXtrCYzBJ/YDutaxwD7Opsv4JCYa7gkSv/sfDC+zj6RF
 4IBxvS+dtvbasHPvkUwVIwWNIAoeeIQ=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-hGEBPyK7NuiNhOzNjJWnRg-1; Wed, 17 Jan 2024 02:44:53 -0500
X-MC-Unique: hGEBPyK7NuiNhOzNjJWnRg-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-429a8494838so86427081cf.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 23:44:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705477492; x=1706082292;
 h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y2MLVnm8830qS1Mj7yohBJ2dzsWrUAAFEkJxGDrAOS4=;
 b=IU8rT6+gSfuFJjH9L9bWX41KeyXwOgA8X4ybgOpV3aEo03u2NumiAZ1CgTQnOlziJC
 nAIMAfGpqSr8hkymNlRqcQGT3HQcbz5Nxf51UjeZqYGoxs6j69tyTw6+8E//6WKcb9s/
 T8jXcy6MO8mjPrjNWrcE2V6REtwVdq2T6dBx7hymBdCOdeMVfXZsQynNahNiy8T2blvW
 +AzZL9pd8O0jh7Ie1WVw74cJ5ciV+pq0ArXoyoZIxKHHG1R17XV8MxSeQgBZGqMuJZiH
 rRJu+yYaZzQbcLUzPOfWG/6qKDFqyu50/1RT2Wn3yxCIhHHPKHee6B7t0Zq9WhebxRX1
 lVAA==
X-Gm-Message-State: AOJu0YzRgZuxdzfDzdTL/yRTrQLOBEgefBMqUcX5FPdxErvFk16znu1A
 /k6mB39p40MUJgTuuws7gJ+jR2CyXyTgqm2tzuZm/7bb+gVMhKZPsT2PebvxUEvCYXR2Kd+rLB8
 RcUIfYDdilPcgsF0fM2DbdcwM8eBSPqKnQCYMgR0=
X-Received: by 2002:ac8:5813:0:b0:429:fea0:e7ee with SMTP id
 g19-20020ac85813000000b00429fea0e7eemr3162255qtg.40.1705477492662; 
 Tue, 16 Jan 2024 23:44:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEaFGM+oMOcUuk3LB+gWAq3b7wMgtxRW9hkP9telOihbYQnb6bZAiSkEIJsW/3E6CbYrfQquhMWxfmkdJCd9oI=
X-Received: by 2002:ac8:5813:0:b0:429:fea0:e7ee with SMTP id
 g19-20020ac85813000000b00429fea0e7eemr3162250qtg.40.1705477492352; Tue, 16
 Jan 2024 23:44:52 -0800 (PST)
Received: from 744723338238 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 17 Jan 2024 02:44:51 -0500
From: Andrea Bolognani <abologna@redhat.com>
References: <20240116230924.23053-1-farosas@suse.de>
 <45c847e8-01e9-42f0-a2a7-2061fc9e08e2@redhat.com>
MIME-Version: 1.0
In-Reply-To: <45c847e8-01e9-42f0-a2a7-2061fc9e08e2@redhat.com>
Date: Wed, 17 Jan 2024 02:44:51 -0500
Message-ID: <CABJz62OD0ZZSY16sDNRiTuPEBygy9Y6rUgRrwoA6N_yg8cgGAQ@mail.gmail.com>
Subject: Re: Re: [PATCH] tests/docker: Add sqlite3 module to openSUSE Leap
 container
To: Thomas Huth <thuth@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Claudio Fontana <cfontana@suse.de>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=abologna@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jan 17, 2024 at 08:18:27AM +0100, Thomas Huth wrote:
> On 17/01/2024 00.09, Fabiano Rosas wrote:
> > Avocado needs sqlite3:
> >
> >    Failed to load plugin from module "avocado.plugins.journal":
> >    ImportError("Module 'sqlite3' is not installed.
> >    Use: sudo zypper install python311 to install it")
> >
> > Include the appropriate package in the dockerfile.
> >
> >  From 'zypper info python311':
> >    "This package supplies rich command line features provided by
> >    readline, and sqlite3 support for the interpreter core, thus forming
> >    a so called "extended" runtime."

Weird choice on Python's part to have sqlite3 support as part of the
standard library IMO, but that's "batteries included" for you :)

> > +++ b/tests/docker/dockerfiles/opensuse-leap.docker
> > @@ -90,6 +90,7 @@ RUN zypper update -y && \
> >              pcre-devel-static \
> >              pipewire-devel \
> >              pkgconfig \
> > +           python311 \
> >              python311-base \
> >              python311-pip \
> >              python311-setuptools \
>
> AFAIK tests/docker/dockerfiles/opensuse-leap.docker is auto-generated, so
> this will be lost once somebody else runs lcitool again...
>
> I don't really have a clue, but I guess this has to be fixed in the upstream
> lcitool first ( https://gitlab.com/libvirt/libvirt-ci ), and then we need to
> update our lcitool status in QEMU afterwards. Maybe Daniel can advise for
> the right stteps here...?

It looks like a bunch of mappings are maintained in
tests/lcitool/mappings.yml instead of the main lcitool repository. So
I think you need to apply the diff below, then run

  $ git submodule update --init tests/lcitool/libvirt-ci
  $ tests/lcitool/refresh

to propagate the changes to the generated files.


diff --git a/tests/lcitool/mappings.yml b/tests/lcitool/mappings.yml
index 0b908882f1..407c03301b 100644
--- a/tests/lcitool/mappings.yml
+++ b/tests/lcitool/mappings.yml
@@ -59,6 +59,10 @@ mappings:
     CentOSStream8:
     OpenSUSELeap15:

+  python3-sqlite3:
+    CentOSStream8: python38
+    OpenSUSELeap15: python311
+
   python3-tomli:
     # test using tomllib
     apk:
diff --git a/tests/lcitool/projects/qemu.yml b/tests/lcitool/projects/qemu.yml
index 82092c9f17..149b15de57 100644
--- a/tests/lcitool/projects/qemu.yml
+++ b/tests/lcitool/projects/qemu.yml
@@ -97,6 +97,7 @@ packages:
  - python3-pip
  - python3-sphinx
  - python3-sphinx-rtd-theme
+ - python3-sqlite3
  - python3-tomli
  - python3-venv
  - rpm2cpio
-- 
Andrea Bolognani / Red Hat / Virtualization


