Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB8076FF3E
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 13:11:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRsi2-0005QE-T1; Fri, 04 Aug 2023 07:11:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qRsi0-0005PI-B0
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 07:11:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qRshy-000894-AO
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 07:11:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691147460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GaywZvXn+EcxvGHFmRCE09d4m/kmOql0kKOC1tHVg5k=;
 b=Wz0gxIwCkt44h9VZubVXaBX17CIRvIRJDmd3ntEclex/X0nAyL5jSXwGVEDt3T0xrKc1Xm
 xh79oqnr6/9lLOH7HH61SzBpcbQdBD077WfBhJAm3NRvfcaUVgxawO3BxHx90Npf5fcDzE
 zEcAGxxz16Oeyw838+Dn5uoV0kBKxZU=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-472-ZTPX3exWPFi9iw_G3hGYFw-1; Fri, 04 Aug 2023 07:10:57 -0400
X-MC-Unique: ZTPX3exWPFi9iw_G3hGYFw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B8BDD380392D;
 Fri,  4 Aug 2023 11:10:56 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.42.28.105])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9A234492B03;
 Fri,  4 Aug 2023 11:10:55 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 0/1] gitlab: enable ccache for many build jobs
Date: Fri,  4 Aug 2023 12:10:53 +0100
Message-ID: <20230804111054.281802-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

Thomas has previously proposed adding ccache:

   https://lists.nongnu.org/archive/html/qemu-devel/2021-04/msg02189.html

This is an pretty much suggesting the same.

In jobs which are compile heavy the results can be pretty
spectacular. Many jobs get their execution time cut by as
much as 70%, a few even get over 80% saving.

The 'build-XXXX' and 'cross-XXXX' jobs are what benefit.

The 'check-XXXX' jobs won't benefit much as they're not compiling
stuff and likewise the 'container-xxxx' jobs.

Overall we get a 35% reduction in CI minutes consumed.

NB this does not directly correspond to the same wallclock time
reduction, since we're only improving the 'build' stage performance.

Given CI quota controls reducing CI minutes consumed is beneficial
even if wallclock time is unchanged.

When the cache is cold, however, there is some degradation of
performance. The biggest issue was/is the msys jobs, which
had to be mitigated through ccache tuning.

The breakdown in my test pipelines between totally empty
cache and (what ought to be) a 100% hit rate for cache:

                         msys2-64bit:  61.51% saving (4159 secs -> 1601 secs)
                check-python-minreqs:                ( 109 secs ->  104 secs)
                               pages:                ( 437 secs ->  481 secs)
                    check-cfi-x86_64:                ( 837 secs ->  880 secs)
               check-system-opensuse:                (1351 secs -> 1342 secs)
                 check-system-centos:                ( 922 secs ->  945 secs)
                   crash-test-fedora:                ( 599 secs ->  577 secs)
                 check-system-fedora:                ( 770 secs ->  799 secs)
                   crash-test-debian:                (1489 secs -> 1499 secs)
                 check-system-debian:                (1342 secs -> 1314 secs)
                 check-system-ubuntu:                ( 608 secs ->  604 secs)
                 check-system-alpine:                ( 298 secs ->  297 secs)
                         msys2-32bit:  51.55% saving (3486 secs -> 1689 secs)
         aarch64-macos-12-base-build:                (1050 secs ->  973 secs)
                x64-freebsd-13-build:                (1417 secs -> 1452 secs)
                           check-dco:                (  35 secs ->   33 secs)
                         check-patch:                (  34 secs ->   34 secs)
         build-tools-and-docs-debian:  30.13% saving ( 395 secs ->  276 secs)
                 build-libvhost-user:                ( 122 secs ->  123 secs)
              build-without-defaults:  34.01% saving ( 691 secs ->  456 secs)
                           build-tci:                (1199 secs -> 1187 secs)
                      build-oss-fuzz:                ( 880 secs ->  909 secs)
                                gcov:  68.24% saving (1206 secs ->  383 secs)
                          tsan-build:  77.12% saving (1333 secs ->  305 secs)
                    build-cfi-x86_64:  10.10% saving (2625 secs -> 2360 secs)
                          clang-user:                (1850 secs -> 1797 secs)
                        clang-system:  66.36% saving (1605 secs ->  540 secs)
               build-tricore-softmmu:                ( 228 secs ->  231 secs)
                  build-some-softmmu:                ( 519 secs ->  526 secs)
                  build-user-hexagon:  44.66% saving ( 309 secs ->  171 secs)
                   build-user-static:                (1338 secs -> 1298 secs)
                          build-user:                (1552 secs -> 1600 secs)
                  build-tcg-disabled:                ( 879 secs ->  819 secs)
               build-system-opensuse:  55.97% saving (1088 secs ->  479 secs)
                 build-system-centos:                (1053 secs -> 1056 secs)
                 build-system-fedora:  69.61% saving (1244 secs ->  378 secs)
                 build-system-debian:  72.69% saving (1095 secs ->  299 secs)
                 build-system-ubuntu:  63.69% saving ( 851 secs ->  309 secs)
                 build-system-alpine:  71.24% saving (1109 secs ->  319 secs)
                cross-arm64-xen-only:  76.59% saving ( 786 secs ->  184 secs)
                cross-amd64-xen-only:  73.49% saving ( 679 secs ->  180 secs)
                  cross-win64-system:  71.48% saving (2952 secs ->  842 secs)
                  cross-win32-system:  56.86% saving (2406 secs -> 1038 secs)
             cross-mips64el-kvm-only:  72.67% saving ( 611 secs ->  167 secs)
                cross-s390x-kvm-only:  67.55% saving ( 527 secs ->  171 secs)
                    cross-s390x-user:  14.92% saving (1146 secs ->  975 secs)
                  cross-s390x-system:  83.31% saving (1989 secs ->  332 secs)
                  cross-riscv64-user:                ( 165 secs ->  170 secs)
                cross-riscv64-system:  82.25% saving (2118 secs ->  376 secs)
              cross-ppc64el-kvm-only:  68.51% saving ( 578 secs ->  182 secs)
                  cross-ppc64el-user:                (1113 secs -> 1063 secs)
                cross-ppc64el-system:  82.69% saving (2062 secs ->  357 secs)
                 cross-mips64el-user:                (1201 secs -> 1258 secs)
               cross-mips64el-system:  81.12% saving (2023 secs ->  382 secs)
                   cross-mipsel-user:                (1232 secs -> 1223 secs)
                 cross-mipsel-system:  83.04% saving (2093 secs ->  355 secs)
                      cross-i386-tci:                (1358 secs -> 1333 secs)
                     cross-i386-user:                (1069 secs -> 1182 secs)
                cross-arm64-kvm-only:  66.25% saving ( 480 secs ->  162 secs)
                    cross-arm64-user:                (1126 secs -> 1097 secs)
                  cross-arm64-system:  84.11% saving (2202 secs ->  350 secs)
                    cross-armhf-user:                (1101 secs -> 1162 secs)
                    cross-armel-user:                (1096 secs -> 1173 secs)
                    python-container:                ( 136 secs ->  137 secs)
       amd64-opensuse-leap-container:                ( 146 secs ->  146 secs)
          amd64-ubuntu2204-container:                ( 142 secs ->  138 secs)
              amd64-debian-container:                ( 144 secs ->  146 secs)
              amd64-alpine-container:                ( 134 secs ->  131 secs)
        win64-fedora-cross-container:                ( 166 secs ->  160 secs)
        win32-fedora-cross-container:                ( 160 secs ->  163 secs)
         i386-fedora-cross-container:                ( 133 secs ->  121 secs)
         cris-fedora-cross-container:                ( 113 secs ->  114 secs)
       xtensa-debian-cross-container:                ( 116 secs ->  117 secs)
      tricore-debian-cross-container:                ( 120 secs ->  124 secs)
      sparc64-debian-cross-container:                ( 107 secs ->  108 secs)
          sh4-debian-cross-container:                ( 103 secs ->  104 secs)
        s390x-debian-cross-container:                ( 145 secs ->  139 secs)
 riscv64-debian-test-cross-container:                ( 106 secs ->  108 secs)
      riscv64-debian-cross-container:                ( 128 secs ->  128 secs)
      ppc64el-debian-cross-container:                ( 141 secs ->  148 secs)
        powerpc-test-cross-container:                ( 120 secs ->  119 secs)
       mipsel-debian-cross-container:                ( 137 secs ->  136 secs)
         mips-debian-cross-container:                ( 109 secs ->  106 secs)
     mips64el-debian-cross-container:                ( 145 secs ->  139 secs)
       mips64-debian-cross-container:                ( 105 secs ->  105 secs)
         m68k-debian-cross-container:                ( 106 secs ->  105 secs)
         hppa-debian-cross-container:                ( 106 secs ->  104 secs)
             hexagon-cross-container:                ( 153 secs ->  151 secs)
        armhf-debian-cross-container:                ( 146 secs ->  143 secs)
        armel-debian-cross-container:                ( 140 secs ->  147 secs)
        arm64-debian-cross-container:                ( 143 secs ->  146 secs)
   amd64-debian-user-cross-container:                ( 169 secs ->  165 secs)
        amd64-debian-cross-container:                ( 135 secs ->  133 secs)
        alpha-debian-cross-container:                ( 105 secs ->  106 secs)
              amd64-fedora-container:                ( 159 secs ->  156 secs)
             amd64-centos8-container:                ( 146 secs ->  148 secs)
Total  35.74% saving (78591 secs -> 50500 secs)

Daniel P. Berrangé (1):
  gitlab: enable ccache for many build jobs

 .gitlab-ci.d/buildtest-template.yml           | 11 ++++++++
 .gitlab-ci.d/crossbuild-template.yml          | 26 +++++++++++++++++++
 .gitlab-ci.d/windows.yml                      | 13 ++++++++--
 docs/devel/ci-jobs.rst.inc                    |  7 +++++
 .../dockerfiles/debian-hexagon-cross.docker   |  9 ++++++-
 5 files changed, 63 insertions(+), 3 deletions(-)

-- 
2.41.0


