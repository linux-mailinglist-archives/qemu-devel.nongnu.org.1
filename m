Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FEA70DDD4
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 15:47:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1SL1-0006zc-97; Tue, 23 May 2023 09:46:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchamart@redhat.com>)
 id 1q1SKy-0006z3-TX
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:46:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kchamart@redhat.com>)
 id 1q1SKw-0000p6-5F
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:46:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684849561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EuCBH3yoFQG8LOIbtmJg9pfMudFtseebYt+x5TlbMj8=;
 b=Nmd2VvjsasrscFpKSjz1mVsb5w6GJqAz4x/dC/j7Kh97gXx22fad2tsuJghMmqSZH/OZDl
 RBOn236wuJB4kuBhBq4ZYq21CEYgODntZGO80L24dlaijHFcPSlxsGKzI96bZE2iOhZpom
 P3P81+VrTlL3BHc6kTg/y7x3wPzTKYs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-623-ryL14jTMNPqTf_m5sQqJ4Q-1; Tue, 23 May 2023 09:45:57 -0400
X-MC-Unique: ryL14jTMNPqTf_m5sQqJ4Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D23B7185A793;
 Tue, 23 May 2023 13:45:56 +0000 (UTC)
Received: from pinwheel (unknown [10.39.194.85])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C57B1121315;
 Tue, 23 May 2023 13:45:55 +0000 (UTC)
Date: Tue, 23 May 2023 15:45:52 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v2] docs: build-system: rename "default-configs" to
 "configs"
Message-ID: <ZGzDkL9ZOK7JgMNs@pinwheel>
References: <20230523133117.2278587-1-kchamart@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523133117.2278587-1-kchamart@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kchamart@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

On Tue, May 23, 2023 at 03:31:17PM +0200, Kashyap Chamarthy wrote:

[I missed to include version history under "---"; now done]

> Commit 812b31d3f9 (configs: rename default-configs to configs and
> reorganise, 2021-07-07) did the rename.
> 
> Reflect that update also in the documentation.
> 
> Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>

In v2:

- Address Lei Wang's feedback from v1:
  https://lists.nongnu.org/archive/html/qemu-devel/2023-05/msg02988.html

(I'd appreciate a closer look at the edits in docs/devel/kconfig.rst, to
make sure I'm referring to the correct subdirectory where appropriate:
configs/devices/ vs. configs/targets/.  I read through the surrounding
text to make the choice, but a second look would be helpful.)

>  docs/devel/build-system.rst | 12 +++++------
>  docs/devel/kconfig.rst      | 40 ++++++++++++++++++++-----------------
>  2 files changed, 28 insertions(+), 24 deletions(-)
> 
> diff --git a/docs/devel/build-system.rst b/docs/devel/build-system.rst
> index 1894721743..20ebcc9ac6 100644
> --- a/docs/devel/build-system.rst
> +++ b/docs/devel/build-system.rst
> @@ -193,7 +193,7 @@ Target-dependent emulator sourcesets:
>    Each emulator also includes sources for files in the ``hw/`` and ``target/``
>    subdirectories.  The subdirectory used for each emulator comes
>    from the target's definition of ``TARGET_BASE_ARCH`` or (if missing)
> -  ``TARGET_ARCH``, as found in ``default-configs/targets/*.mak``.
> +  ``TARGET_ARCH``, as found in ``configs/targets/*.mak``.
>  
>    Each subdirectory in ``hw/`` adds one sourceset to the ``hw_arch`` dictionary,
>    for example::
> @@ -250,8 +250,8 @@ Utility sourcesets:
>  The following files concur in the definition of which files are linked
>  into each emulator:
>  
> -``default-configs/devices/*.mak``
> -  The files under ``default-configs/devices/`` control the boards and devices
> +``configs/devices/*.mak``
> +  The files under ``configs/devices/`` control the boards and devices
>    that are built into each QEMU system emulation targets. They merely contain
>    a list of config variable definitions such as::
>  
> @@ -260,11 +260,11 @@ into each emulator:
>      CONFIG_XLNX_VERSAL=y
>  
>  ``*/Kconfig``
> -  These files are processed together with ``default-configs/devices/*.mak`` and
> +  These files are processed together with ``configs/devices/*.mak`` and
>    describe the dependencies between various features, subsystems and
>    device models.  They are described in :ref:`kconfig`
>  
> -``default-configs/targets/*.mak``
> +``configs/targets/*.mak``
>    These files mostly define symbols that appear in the ``*-config-target.h``
>    file for each emulator [#cfgtarget]_.  However, the ``TARGET_ARCH``
>    and ``TARGET_BASE_ARCH`` will also be used to select the ``hw/`` and
> @@ -457,7 +457,7 @@ Built by Meson:
>    TARGET-NAME is again the name of a system or userspace emulator. The
>    config-devices.mak file is automatically generated by make using the
>    scripts/make_device_config.sh program, feeding it the
> -  default-configs/$TARGET-NAME file as input.
> +  configs/$TARGET-NAME file as input.
>  
>  ``config-host.h``, ``$TARGET_NAME-config-target.h``, ``$TARGET_NAME-config-devices.h``
>    These files are used by source code to determine what features are
> diff --git a/docs/devel/kconfig.rst b/docs/devel/kconfig.rst
> index e3a544e463..73118e5106 100644
> --- a/docs/devel/kconfig.rst
> +++ b/docs/devel/kconfig.rst
> @@ -38,11 +38,11 @@ originated in the Linux kernel, though it was heavily simplified and
>  the handling of dependencies is stricter in QEMU.
>  
>  Unlike Linux, there is no user interface to edit the configuration, which
> -is instead specified in per-target files under the ``default-configs/``
> +is instead specified in per-target files under the ``configs/target/``
>  directory of the QEMU source tree.  This is because, unlike Linux,
> -configuration and dependencies can be treated as a black box when building
> -QEMU; the default configuration that QEMU ships with should be okay in
> -almost all cases.
> +configuration and dependencies can be treated as a black box when
> +building QEMU; the default configuration that QEMU ships with should be
> +okay in almost all cases.
>  
>  The Kconfig language
>  --------------------
> @@ -103,11 +103,12 @@ directives can be included:
>  **default value**: ``default <value> [if <expr>]``
>  
>    Default values are assigned to the config symbol if no other value was
> -  set by the user via ``default-configs/*.mak`` files, and only if
> -  ``select`` or ``depends on`` directives do not force the value to true
> -  or false respectively.  ``<value>`` can be ``y`` or ``n``; it cannot
> -  be an arbitrary Boolean expression.  However, a condition for applying
> -  the default value can be added with ``if``.
> +  set by the user via
> +  ``configs/devices/TARGETNAME-softmmu/*.mak`` files, and only
> +  if ``select`` or ``depends on`` directives do not force the value to
> +  true or false respectively.  ``<value>`` can be ``y`` or ``n``; it
> +  cannot be an arbitrary Boolean expression.  However, a condition for
> +  applying the default value can be added with ``if``.
>  
>    A configuration element can have any number of default values (usually,
>    if more than one default is present, they will have different
> @@ -119,8 +120,8 @@ directives can be included:
>    This is similar to ``select`` as it applies a lower limit of ``y``
>    to another symbol.  However, the lower limit is only a default
>    and the "implied" symbol's value may still be set to ``n`` from a
> -  ``default-configs/*.mak`` files.  The following two examples are
> -  equivalent::
> +  ``configs/devices/TARGETNAME-softmmu/*.mak`` files.  The following
> +  two examples are equivalent::
>  
>      config FOO
>        bool
> @@ -146,8 +147,9 @@ declares its dependencies in different ways:
>        bool
>  
>    Subsystems always default to false (they have no ``default`` directive)
> -  and are never visible in ``default-configs/*.mak`` files.  It's
> -  up to other symbols to ``select`` whatever subsystems they require.
> +  and are never visible in ``configs/devices/TARGETNAME-softmmu/*.mak``
> +  files.  It's up to other symbols to ``select`` whatever subsystems
> +  they require.
>  
>    They sometimes have ``select`` directives to bring in other required
>    subsystems or buses.  For example, ``AUX`` (the DisplayPort auxiliary
> @@ -229,7 +231,8 @@ declares its dependencies in different ways:
>    cannot be started at all without it.  It should be listed under
>    ``imply`` if (depending on the QEMU command line) the board may or
>    may not be started without it.  Boards also default to false; they are
> -  enabled by the ``default-configs/*.mak`` for the target they apply to.
> +  enabled by the ``configs/targets/TARGETNAME-softmmu/*.mak`` for the
> +  target they apply to.
>  
>  **internal elements**
>  
> @@ -241,18 +244,19 @@ declares its dependencies in different ways:
>  
>    Internal elements group code that is useful in several boards or
>    devices.  They are usually enabled with ``select`` and in turn select
> -  other elements; they are never visible in ``default-configs/*.mak``
> -  files, and often not even in the Makefile.
> +  other elements; they are never visible in
> +  ``configs/devices/TARGETNAME-softmmu/*.mak`` files, and often not even
> +  in the Makefile.
>  
>  Writing and modifying default configurations
>  --------------------------------------------
>  
>  In addition to the Kconfig files under hw/, each target also includes
> -a file called ``default-configs/TARGETNAME-softmmu.mak``.  These files
> +a file called ``configs/devices/TARGETNAME-softmmu.mak``.  These files
>  initialize some Kconfig variables to non-default values and provide the
>  starting point to turn on devices and subsystems.
>  
> -A file in ``default-configs/`` looks like the following example::
> +A file in ``configs/devices/`` looks like the following example::
>  
>      # Default configuration for alpha-softmmu
>  
> -- 
> 2.40.1
> 

-- 
/kashyap


