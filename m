Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7967D826BA6
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 11:37:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMn07-00029g-UD; Mon, 08 Jan 2024 05:36:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rMn05-00029L-PX
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 05:36:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rMn04-0006Lj-8j
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 05:36:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704710215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=HnpApLOwMe/ygTFel2nsn3HHIiBDKWov4sVKGCajYMo=;
 b=CL8xntXTHcMh69JapdZn3KiUSQMEyQDxJDegFebfuPfitgVGIBb+AN/n8NvFXupkMGCsqB
 2xcnavikKL0MU4yuYhsjmMGTcHhZ4ABfMqBY5mOxqICDo7G+u3B+blpO/wT7/ZqaELf8h5
 QEoqpspS6QSBXxvM/9R3wmPj2O9ftn8=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-AI_XJT_KPQKlfpCnfRQhSQ-1; Mon, 08 Jan 2024 05:36:53 -0500
X-MC-Unique: AI_XJT_KPQKlfpCnfRQhSQ-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-6d9bd4fa279so600478b3a.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 02:36:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704710213; x=1705315013;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HnpApLOwMe/ygTFel2nsn3HHIiBDKWov4sVKGCajYMo=;
 b=qsVb2tGTuqdonXNxiFxFV9k2nf6rjFumm6XawCKfWr/qVapiWVLfe8+Q7lqBnjOuc2
 U4Z7jJCxBWXuOLL6VROcQPVXKNGXvPpIpeO1ULX3828EQcY2RAP8I0WN86fry9xQD2O7
 p/8OjZIF+SKrEllbnqxJiHf5IEXm7lwvQeNDdC0yz3VHD2WEyf6nVUhOX3Ia94nLklki
 A/TohWoKVnNfvaBsv4GX+xaagulXgkhJTUvEw8Grbj5wCG0KR7qaG+4hDnjWNxdtUmEX
 q3FXtIBPajrPMv3nqDcZ+vwTuhHIvUWhjtIl7zwNPcKYi+Tvg1sn/wOCxmM1jsx5mbiR
 lKaQ==
X-Gm-Message-State: AOJu0Yy2cvessJaMg4L4+sFQJr6YU1VFt2sqgKjRsM1smGHe8IYWO9Bk
 ckV+JnYzmPeoVapHwpoMTG9xD+q4FVi7z2MjCtXCTOnlUVtZWOUhqDMhAAUSEGgu3csNs7rFRRK
 It2JCfOpdJSfdOVuVHygqliw=
X-Received: by 2002:a05:6a20:da9f:b0:199:844f:72d9 with SMTP id
 iy31-20020a056a20da9f00b00199844f72d9mr755542pzb.8.1704710212704; 
 Mon, 08 Jan 2024 02:36:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHpPGjm/AvEG4MxZ80kOzqMOC1Jj0Yv0W1QKcdKA718jwYFlVWKENDISfW05x/FCopRXcwPtw==
X-Received: by 2002:a05:6a20:da9f:b0:199:844f:72d9 with SMTP id
 iy31-20020a056a20da9f00b00199844f72d9mr755537pzb.8.1704710212424; 
 Mon, 08 Jan 2024 02:36:52 -0800 (PST)
Received: from localhost.localdomain ([116.73.134.99])
 by smtp.googlemail.com with ESMTPSA id
 u11-20020a17090282cb00b001d3563c87a6sm5899502plz.281.2024.01.08.02.36.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jan 2024 02:36:52 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: 
Cc: Ani Sinha <anisinha@redhat.com>, peter.maydell@linaro.org,
 crosa@redhat.com, philmd@linaro.org, bleal@redhat.com, mst@redhat.com,
 wainersm@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH 0/2] acpi/tests/avocado/bits: disable smilatency tests
Date: Mon,  8 Jan 2024 16:06:41 +0530
Message-ID: <20240108103643.4434-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.098,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Import smilatency test from bios-bits and disable it. It is causing some
flakyness and occassional failures in bios-bits avocado tests.
Please see ticket https://gitlab.com/qemu-project/qemu/-/issues/2077

CC: peter.maydell@linaro.org
CC: crosa@redhat.com
CC: philmd@linaro.org
CC: bleal@redhat.com
CC: mst@redhat.com
CC: wainersm@redhat.com
CC: qemu-devel@nongnu.org

Ani Sinha (2):
  acpi/tests/avocado/bits: import smilatency test from bits in order to
    disable it
  acpi/tests/avocado/bits: disable smilatency tests

 .../acpi-bits/bits-tests/smilatency.py2       | 107 ++++++++++++++++++
 1 file changed, 107 insertions(+)
 create mode 100644 tests/avocado/acpi-bits/bits-tests/smilatency.py2

-- 
2.42.0


