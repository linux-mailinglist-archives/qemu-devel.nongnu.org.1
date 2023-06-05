Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C041722C1D
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 18:03:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Ce7-00072t-9C; Mon, 05 Jun 2023 12:01:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q6CdN-0006iA-Sk
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 12:00:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q6CdB-0004l5-Ti
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 12:00:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685980817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Jatwds3MjYAh586vWjlskMqeoVFUF3c2ge+iF7sqI2I=;
 b=cO818ypb9R8NBRlwXj/EJ2vGJVGXFyXEqqjypy3+Avg1DFD9c3Cp+ojfXn9Nj8GzruUVOy
 PRXMHxhjzxto2y3U6Y7P7abBFqz8z4EY/dAkRgL1nKRTxjwKT7h7jVY4m0sZgEPfsYjvGg
 dp6/a3vUmSaUQiMM0fsp5n2VTQ1kvDs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-jm9-pNLcPzSo3vDHIzg9_w-1; Mon, 05 Jun 2023 12:00:16 -0400
X-MC-Unique: jm9-pNLcPzSo3vDHIzg9_w-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9745c72d99cso319278066b.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 09:00:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685980815; x=1688572815;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Jatwds3MjYAh586vWjlskMqeoVFUF3c2ge+iF7sqI2I=;
 b=DBhWSUZclakFB7+P2QQBh0ZvPx20ZYJz+PeSEq4rnvMCMRzUnss/QQCETCMuFRTHmm
 Gf8481G1j4EsrAzBywMqgVUQhFOEEbWcmbZW1fJXs+w75Uz/jrtBW9KtC4eyii9bxwG9
 +sYQe+eIJnali0Ad+s9qyCu4rqDZux67+v86Qss3k0mtUp0rbzKwKIhbfxDY0P1dID21
 ov6nqZ2vvYbhIJdOT+leDwt7X7m8FnWsXOZrIIbmbd10SMSSwa6VrBNyfLwrh2Yxa7sO
 qSQIAiecfJ/52TkJ8VzYhE5MoTVQVEv8VulDahDLeAhayEI3Fqxfx3j/MCr9EUkzfhF/
 6doA==
X-Gm-Message-State: AC+VfDy0jdDWBTGPcr6RrAO+EZnGQpiVSJBKoRHNVl5DdVPNHZA0kNJq
 r2JeM+vrMY9xJBGyN1h5dr3Bq+v8aY+FEe89nrzDduYTCDC173mufpgt2nve6RdgxMJoc0S5MPF
 Zf59NAEQ3Q0vNInqU6G3/XMPolCf4WWwKLm3dU9c+mAp+QAoHFaNG+YPvWq4CFkJiWdmGEDqruV
 U=
X-Received: by 2002:a17:907:26c8:b0:969:e9ec:9a0 with SMTP id
 bp8-20020a17090726c800b00969e9ec09a0mr6653547ejc.77.1685980815206; 
 Mon, 05 Jun 2023 09:00:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6BLszNyumUeBwmy7TsPLa2bw1+P/7+HR53J19gkR2JhXm9y9ZCQOI31STJnSees1eBY01wVA==
X-Received: by 2002:a17:907:26c8:b0:969:e9ec:9a0 with SMTP id
 bp8-20020a17090726c800b00969e9ec09a0mr6653522ejc.77.1685980814819; 
 Mon, 05 Jun 2023 09:00:14 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 h21-20020a170906261500b00977cad140a8sm2635659ejc.218.2023.06.05.09.00.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 09:00:14 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, peter.maydell@linaro.org, alex.bennee@linaro.org,
 jsnow@redhat.com, kconsul@linux.vnet.ibm.com
Subject: [PATCH v2 0/2] Revert recent Avocado changes
Date: Mon,  5 Jun 2023 18:00:10 +0200
Message-Id: <20230605160012.339685-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
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
in the system packages.  However, this requires more work, so for now
reintroduce the avocado-specific virtual environment instead of using
pyvenv/.

Paolo

Supersedes: <20230605075823.48871-1-pbonzini@redhat.com>

Paolo Bonzini (2):
  Revert "tests/requirements.txt: bump up avocado-framework version to
    101.0"
  tests: Use separate virtual environment for avocado

 .gitlab-ci.d/buildtest.yml                    |  6 ++--
 docs/devel/acpi-bits.rst                      |  6 ++--
 docs/devel/testing.rst                        | 14 ++++----
 .../org.centos/stream/8/x86_64/test-avocado   |  4 +--
 scripts/device-crash-test                     |  2 +-
 tests/Makefile.include                        | 32 +++++++++----------
 tests/requirements.txt                        |  9 ++----
 tests/vm/Makefile.include                     |  2 +-
 8 files changed, 35 insertions(+), 40 deletions(-)

-- 
2.40.1


