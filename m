Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AEBE0A1386D
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Jan 2025 11:59:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYNbC-0006xo-Nf; Thu, 16 Jan 2025 05:59:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tYNb0-0006vk-9o
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 05:59:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tYNax-0007rw-A9
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 05:59:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737025163;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HwDYeGbCpeCLgUGYuu+iuURX5Kf7ZbBld7h0VMmJ+C0=;
 b=K6dSQL3oxsTZkhIy02oHsb/AEXBxWAzeF4bP8ytakzC0aposOIzmTqjDySkt59OHsOrVWA
 /1MEqqho80zQ3l7Afu0SwzuKBxn9NHXK1wggvw/vw2MeqIV9a5zrqzQQM1Mjjmo6FMpuhQ
 QeYBm409o2JFX0J4gTn0oJMrPEkpQc0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-136-8ZTVkCvON_CYWDtnj-Xjvg-1; Thu,
 16 Jan 2025 05:59:19 -0500
X-MC-Unique: 8ZTVkCvON_CYWDtnj-Xjvg-1
X-Mimecast-MFC-AGG-ID: 8ZTVkCvON_CYWDtnj-Xjvg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3D3961955D82; Thu, 16 Jan 2025 10:59:17 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.111])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ABC5B30001BE; Thu, 16 Jan 2025 10:59:13 +0000 (UTC)
Date: Thu, 16 Jan 2025 10:59:10 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] docs/about: Change notes on x86 machine type deprecation
 into a general one
Message-ID: <Z4jmfnfLdsTbHRFd@redhat.com>
References: <20250116064644.65670-1-thuth@redhat.com>
 <ad3d06df-f0ae-4508-b979-c838b3647510@linaro.org>
 <Z4jPGGezEK3XRMl8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z4jPGGezEK3XRMl8@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.793,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, Jan 16, 2025 at 09:19:20AM +0000, Daniel P. Berrangé wrote:
> On Thu, Jan 16, 2025 at 09:48:50AM +0100, Philippe Mathieu-Daudé wrote:
> > On 16/1/25 07:46, Thomas Huth wrote:
> > > We now have a general note about versioned machine types getting
> > > deprecated and removed at the beginning of the deprecated.rst file,
> > > so we should also have a general note about this in removed-features.rst
> > > (which will also apply to versioned non-x86 machine types) instead of
> > > listing individual old machine types in the document.
> > > 
> > > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > > ---
> > >   docs/about/deprecated.rst       |  7 -------
> > >   docs/about/removed-features.rst | 11 +++++------
> > >   2 files changed, 5 insertions(+), 13 deletions(-)
> > > 
> > > diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> > > index 4a3c302962..7b42d6eecc 100644
> > > --- a/docs/about/deprecated.rst
> > > +++ b/docs/about/deprecated.rst
> > > @@ -236,13 +236,6 @@ deprecated; use the new name ``dtb-randomness`` instead. The new name
> > >   better reflects the way this property affects all random data within
> > >   the device tree blob, not just the ``kaslr-seed`` node.
> > > -``pc-i440fx-2.4`` up to ``pc-i440fx-2.12`` (since 9.1)
> > > -''''''''''''''''''''''''''''''''''''''''''''''''''''''
> > > -
> > > -These old machine types are quite neglected nowadays and thus might have
> > > -various pitfalls with regards to live migration. Use a newer machine type
> > > -instead.
> > > -
> > >   PPC 405 ``ref405ep`` machine (since 9.1)
> > >   ''''''''''''''''''''''''''''''''''''''''
> > > diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
> > > index c6616ce05e..156c0c253c 100644
> > > --- a/docs/about/removed-features.rst
> > > +++ b/docs/about/removed-features.rst
> > > @@ -972,6 +972,11 @@ from Linux in 2021, and is not supported anymore by QEMU either.
> > >   System emulator machines
> > >   ------------------------
> > > +Note: Versioned machine types that have been introduced in a QEMU version
> > > +that has initially been released more than 6 years before are considered
> > > +obsolete and will be removed without further notice in this document.
> > > +Please use newer machine types instead.
> > 
> > This is an improvement. I still wonder if we shouldn't list them removed
> > machines here, to help old users.
> > 
> >   Removed in 4.0:
> >     - pc-0.10
> >     - ...
> >   Removed in 9.0:
> >     - pc-i440fx-2.3
> >   Remove in 10.0:
> >     - pc-i440fx-2.4
> >     - pc-i440fx-2.5
> >     - pc-i440fx-2.6
> >     - pc-q35-2.4
> >     - pc-q35-2.5
> >     - pc-q35-2.6
> >     - ARM virt-2.6
> >     ...
> > 
> > ?
> 
> A big part of the reason for the macros for machine type deprecation & then
> skipping machine registration, was to eliminate repeated manual work that is
> visible to users if forgotten. 
> 
> We still have the actual code deletion which is manual, but that's harmless
> as even if forgotten, such that the code exists, the machine type will have
> been entirely removed from view.
> 
> As such I'm pretty reluctant to suggest we create a new place which needs
> manually updating when we remove machine types.
> 
> I wonder if its possible to get an auto-generated version number into the
> documentation though ?

To answer my own question, yes with something like this:

diff --git a/docs/conf.py b/docs/conf.py
index 31bb9a3789..899ad13305 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -110,6 +110,22 @@
     else:
         version = release = "unknown version"
 
+bits = version.split(".")
+major = int(bits[0])
+minor = int(bits[1])
+micro = int(bits[2])
+
+# Dev snapshot, adjust to next release version
+if micro >= 50:
+    micro = 0
+    minor += 1
+    if minor == 3:
+        major += 1
+        minor = 0
+
+ver_machine_deprecation_version = "%d.%d.%d" % (major - 3, minor, micro)
+ver_machine_deletion_version = "%d.%d.%d" % (major - 6, minor, micro)
+
 # The language for content autogenerated by Sphinx. Refer to documentation
 # for a list of supported languages.
 #
@@ -138,7 +154,18 @@
 # environment variable is not set is for the benefit of readthedocs
 # style document building; our Makefile always sets the variable.
 confdir = os.getenv('CONFDIR', "/etc/qemu")
-rst_epilog = ".. |CONFDIR| replace:: ``" + confdir + "``\n"
+
+vars = {
+    "CONFDIR": confdir,
+    "VER_MACHINE_DEPRECATION_VERSION": ver_machine_deprecation_version,
+    "VER_MACHINE_DELETION_VERSION": ver_machine_deletion_version,
+}
+
+rst_epilog = "".join([
+    ".. |" + key + "| replace:: ``" + vars[key] + "``\n"
+    for key in vars.keys()
+])
+
 # We slurp in the defs.rst.inc and literally include it into rst_epilog,
 # because Sphinx's include:: directive doesn't work with absolute paths
 # and there isn't any one single relative path that will work for all


Then....


> 
> eg, so we can have an entry in 'deprecated.rst'
> 
>   Versioned machine types for x86_64, i386, aarch64  <other targets here>
>   -----------------------------------------------------------------------
> 
>   In accordance with our versioned machine type deprecation policy,
>   all machine types older than 7.0.0 have been deprecated.

use   |VER_MACHINE_DEPRECATION_VERSION|  here 

> 
> and in 'removed-features.rst'
> 
>   Versioned machine types for x86_64, i386, aarch64  <other targets here>
>   -----------------------------------------------------------------------
> 
>   In accordance with our versioned machine type removal policy,
>   all machine types older than 4.1.0 have been removed.

use   |VER_MACHINE_DELETION_VERSION|  here 

though, we should not add to removed-features.rst until 10.1.0 cycle
since we don't start to do automatic deletion until then.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


