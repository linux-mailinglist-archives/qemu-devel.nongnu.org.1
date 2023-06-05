Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4488972205E
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 10:00:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6575-0004rC-8M; Mon, 05 Jun 2023 03:58:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q656o-0004qD-Hw
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 03:58:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q656l-0001Ii-Kp
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 03:58:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685951910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0apUBCmFVSq7/6F1F1ThPwDSq/35D1mhL93rEhe6Vto=;
 b=h6CUid3sKkaaR1kODtNuA4ifPcOkYKXa/vVbmzBx1nZuedtgx2d6w/URhTvE4UEOXEzoUW
 BZbFONopm+/sei2Pt5KJH5MDrXSwFQOPZKqkc8zjW8kdfZatce1N5epK14Ax/FDHge6To7
 mI2DN9qLxCXtS4OUHmO+SQuS4NF2RkI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-AoMb4Od1N6uIVr9X6b4Ypg-1; Mon, 05 Jun 2023 03:58:29 -0400
X-MC-Unique: AoMb4Od1N6uIVr9X6b4Ypg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-94a35b0d4ceso320176066b.3
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 00:58:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685951907; x=1688543907;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0apUBCmFVSq7/6F1F1ThPwDSq/35D1mhL93rEhe6Vto=;
 b=cq17KBTwQkAsEDFsoRYnwZAfEkdd6S9D6DWXS164qr9OHyJmYuspZKo/W4SYoCUqV+
 pO29zp0DDVVVPCdz5NhBaumQ17raN7Plw0mllhlv2iY82l7caLLICeO2ahH5hGllrTB6
 pfxzhDExI3imBX0mQNq+cl7ZKxc6L+Re19FW85nnIuqV94IkcuTDYSEzfHatXY+MkvZ8
 gEw+8dczjQezwPRmB2VCAFo5LHCugpq7Mt5sc5HZvvy5SJQfdhwW/pKbVymPd+SZdWS4
 6xJWyP9Zphi79EmpJOSgghpB1/4Wg8FNnSEZWdTh10nKX1g2tRvn+dqIss++wuLn1E1D
 yaWg==
X-Gm-Message-State: AC+VfDydgbc81sdXeXoy4Olgk6YuTA+9V4pHPeroGHyKFl/d5+GW3xL1
 SaP8n7yHrI4E0bL+Z2i9EMhHw2Dy4nyymH7F3pOWxP6QPXTauOMrms4wTJh/PpB5DPt+bsFYG5l
 d4uCfuVMCgNOIUzqmm2HeeyDtl110hnydCeQjOlqO8UpmVgr2ekGmmryuVgR1noWMX6ONxlD9ZV
 M=
X-Received: by 2002:a17:907:c1f:b0:975:942e:81f1 with SMTP id
 ga31-20020a1709070c1f00b00975942e81f1mr4962146ejc.4.1685951907531; 
 Mon, 05 Jun 2023 00:58:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ55BQm49vXeUXZxcr+f/eIA8zkmjsIbtr7znm57eRpqDRoWGzTX+adqnVBflCmSQqO6sdf5lQ==
X-Received: by 2002:a17:907:c1f:b0:975:942e:81f1 with SMTP id
 ga31-20020a1709070c1f00b00975942e81f1mr4962135ejc.4.1685951907146; 
 Mon, 05 Jun 2023 00:58:27 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 d12-20020a1709063ecc00b0096f03770be2sm3941417ejj.52.2023.06.05.00.58.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 00:58:25 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, peter.maydell@linaro.org, alex.bennee@linaro.org,
 jsnow@redhat.com, kconsul@linux.vnet.ibm.com
Subject: [PATCH 0/2] Fix venv issues with Avocado by reverting to an older
 version
Date: Mon,  5 Jun 2023 09:58:21 +0200
Message-Id: <20230605075823.48871-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

Bumping avocado to version 101 has two issues.  First, there are problems
where Avocado is not logging of command lines or terminal output, and not
collecting Python logs outside the avocado namespace.

Second, the recent changes to Python handling mean that there is a single
virtual environment for all the build, instead of a separate one for testing.
Requiring a too-new version of avocado causes conflicts with any avocado
plugins installed on the host:

   $ make check-venv
   make[1]: Entering directory '/home/berrange/src/virt/qemu/build'
     GIT     ui/keycodemapdb tests/fp/berkeley-testfloat-3 tests/fp/berkeley-softfloat-3 dtc
     VENVPIP install -e /home/berrange/src/virt/qemu/python/
     VENVPIP install -r /home/berrange/src/virt/qemu/tests/requirements.txt
   ERROR: pip's dependency resolver does not currently take into account all the packages that are installed. This behaviour is the source of the following dependency conflicts.
   avocado-framework-plugin-varianter-yaml-to-mux 98.0 requires avocado-framework==98.0, but you have avocado-framework 101.0 which is incompatible.
   avocado-framework-plugin-result-html 98.0 requires avocado-framework==98.0, but you have avocado-framework 101.0 which is incompatible.
   make[1]: Leaving directory '/home/berrange/src/virt/qemu/build'

To avoid this issue, tests/requirements.txt should use a ">=" constraint
and the version of Avocado should be limited to what distros provide
in the system packages.  Only Fedora has Avocado, and more specifically
version 92.0.  For now, this series reverts to the older requirement
(version >=88.1) while leaving further version bumps to future changes.

Paolo

Paolo Bonzini (2):
  Revert "tests/requirements.txt: bump up avocado-framework version to
    101.0"
  tests: update avocado installation to use mkvenv

 python/tests/minreqs.txt |  3 ++-
 tests/Makefile.include   | 26 +++++++++++++-------------
 tests/requirements.txt   |  9 ---------
 3 files changed, 15 insertions(+), 23 deletions(-)
 delete mode 100644 tests/requirements.txt

-- 
2.40.1


