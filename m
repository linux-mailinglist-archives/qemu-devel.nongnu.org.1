Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C19B2712A32
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 18:09:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2Zzo-0004J1-J6; Fri, 26 May 2023 12:08:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2Zzm-0004IR-TB
 for qemu-devel@nongnu.org; Fri, 26 May 2023 12:08:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2Zzk-0002h6-Qg
 for qemu-devel@nongnu.org; Fri, 26 May 2023 12:08:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685117328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BecGd9dO3ZhSYDouC1mKTnkS4/+M2ywTdjMl2CKrfe4=;
 b=esG2GhRLkh/MFd7dyHi4GKXfqWq1qU++zpJvtUafQNXgv9ibz6f97EbJVm+8RjwZO8xq0p
 Stl9wI9VUzks0hSZSbho4lMZfaEoHoc55syHCIvFYyJISIlxVZIMAjJuk1wyTZwdvJQafW
 Cg5yBmjJqBM1ewXmDPGZwhVI05CAp1A=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-DZgDKjtaM6-0MsG2VnzsqA-1; Fri, 26 May 2023 12:08:46 -0400
X-MC-Unique: DZgDKjtaM6-0MsG2VnzsqA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-96f83033b48so112363266b.3
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 09:08:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685117325; x=1687709325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BecGd9dO3ZhSYDouC1mKTnkS4/+M2ywTdjMl2CKrfe4=;
 b=iCNP7CzcCZwUBlvIddRuKZOO81HwyfZg/hzbUiAHzLYhBd3i1tX+rRgLtCg7GF/s23
 Jah/lij3IVfuM7hAqldHVU94E3RIjQNy4IyQtCTjzL3JxT+K5Q+6Mr0fNRfPD8QIICKC
 55uXvqBQa8WAQs1kt+PLoGCD6diwJOhvmCeRS6j7yXvUeK5vKHzd2dw79LcugsHt3i+j
 NFy2gwnOup8fsVgXLyw5/vKo77bMrLR4o7rHG9IX3rZYLicc+B5j5TGm0blK00IqVFVz
 AJnTZ2n8fT0kZ3PgEnx0wNvBNq43n1juPcub48sm7dcjcT8+4amrC1Owm/MLB3GW15CF
 Re2g==
X-Gm-Message-State: AC+VfDzqFZtR1iPLJLHW//yOMPA2hFwVWeeHMN70H1HYH2vx00LoUyx8
 1bMXVdcxlh2+v9h2NwKBpKGfUFq+O/qwUB2f98RimYiEskK5w8Z/XdZuAh/z/KmBvmlA9DIC0Qw
 +5LlmN3oDkY9d8WV3EYlrFeUx98ZqZDXM2gHNK4XdfRL7hMCn+EvERByiWbin1wQLLG5rerLwh9
 E=
X-Received: by 2002:a17:906:ee88:b0:96a:928c:d382 with SMTP id
 wt8-20020a170906ee8800b0096a928cd382mr2186608ejb.48.1685117325482; 
 Fri, 26 May 2023 09:08:45 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4dM1CoV0rPhbPBGaRFetb5yIVSxZprYHAUI2061DfnkCpdhMEWYgJ+9wBOvZAcUpACBUEP6A==
X-Received: by 2002:a17:906:ee88:b0:96a:928c:d382 with SMTP id
 wt8-20020a170906ee8800b0096a928cd382mr2186590ejb.48.1685117325099; 
 Fri, 26 May 2023 09:08:45 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 y17-20020a17090614d100b009658475919csm2291004ejc.188.2023.05.26.09.08.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 May 2023 09:08:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/12] configure: ignore --make
Date: Fri, 26 May 2023 18:08:24 +0200
Message-Id: <20230526160824.655279-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230526160824.655279-1-pbonzini@redhat.com>
References: <20230526160824.655279-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Setting the MAKE variable to a GNU Make executable does not really have
any effect: if a non-GNU Make is used, the QEMU Makefile will fail to
parse.  Just remove everything related to --make and $make as dead code.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure   | 18 +-----------------
 meson.build |  1 -
 2 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/configure b/configure
index 0e9305848955..d674a9667310 100755
--- a/configure
+++ b/configure
@@ -400,20 +400,16 @@ gnu/kfreebsd)
 ;;
 freebsd)
   bsd="yes"
-  make="${MAKE-gmake}"
   # needed for kinfo_getvmmap(3) in libutil.h
 ;;
 dragonfly)
   bsd="yes"
-  make="${MAKE-gmake}"
 ;;
 netbsd)
   bsd="yes"
-  make="${MAKE-gmake}"
 ;;
 openbsd)
   bsd="yes"
-  make="${MAKE-gmake}"
 ;;
 darwin)
   bsd="yes"
@@ -421,7 +417,6 @@ darwin)
 ;;
 sunos)
   solaris="yes"
-  make="${MAKE-gmake}"
 ;;
 haiku)
   pie="no"
@@ -525,9 +520,6 @@ case "$cpu" in
     CPU_CFLAGS="-m64 -mcpu=ultrasparc" ;;
 esac
 
-: ${make=${MAKE-make}}
-
-
 check_py_version() {
     # We require python >= 3.7.
     # NB: a True python conditional creates a non-zero return code (Failure)
@@ -630,7 +622,7 @@ for opt do
   ;;
   --objcc=*)
   ;;
-  --make=*) make="$optarg"
+  --make=*)
   ;;
   --install=*)
   ;;
@@ -897,7 +889,6 @@ Advanced options (experts only):
   --cross-cc-ARCH=CC       use compiler when building ARCH guest test cases
   --cross-cc-cflags-ARCH=  use compiler flags when building ARCH guest tests
   --cross-prefix-ARCH=PREFIX cross compiler prefix when building ARCH guest test cases
-  --make=MAKE              use specified make [$make]
   --python=PYTHON          use specified python [$python]
   --ninja=NINJA            use specified ninja [$ninja]
   --smbd=SMBD              use specified smbd [$smbd]
@@ -950,11 +941,6 @@ then
     fi
 fi
 
-if ! has "$make"
-then
-    error_exit "GNU make ($make) not found"
-fi
-
 if ! check_py_version "$python"; then
   error_exit "Cannot use '$python', Python >= 3.7 is required." \
              "Use --python=/path/to/python to specify a supported Python." \
@@ -1777,7 +1763,6 @@ if test "$container" != no; then
     echo "RUNC=$runc" >> $config_host_mak
 fi
 echo "ROMS=$roms" >> $config_host_mak
-echo "MAKE=$make" >> $config_host_mak
 echo "PYTHON=$python" >> $config_host_mak
 echo "GENISOIMAGE=$genisoimage" >> $config_host_mak
 echo "MESON=$meson" >> $config_host_mak
@@ -2030,7 +2015,6 @@ preserve_env CXXFLAGS
 preserve_env LD
 preserve_env LDFLAGS
 preserve_env LD_LIBRARY_PATH
-preserve_env MAKE
 preserve_env NM
 preserve_env OBJCFLAGS
 preserve_env OBJCOPY
diff --git a/meson.build b/meson.build
index 884b16c74962..2d48aa1e2ef3 100644
--- a/meson.build
+++ b/meson.build
@@ -4028,7 +4028,6 @@ summary(summary_info, bool_yn: true, section: 'Directories')
 # Host binaries
 summary_info = {}
 summary_info += {'git':               config_host['GIT']}
-summary_info += {'make':              config_host['MAKE']}
 summary_info += {'python':            '@0@ (version: @1@)'.format(python.full_path(), python.language_version())}
 summary_info += {'sphinx-build':      sphinx_build}
 if config_host.has_key('HAVE_GDB_BIN')
-- 
2.40.1


