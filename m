Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 88AA9734917
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 00:22:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qB0lr-0002lT-Mj; Sun, 18 Jun 2023 18:21:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qB0lp-0002lF-Al
 for qemu-devel@nongnu.org; Sun, 18 Jun 2023 18:21:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qB0ln-0004U8-Qc
 for qemu-devel@nongnu.org; Sun, 18 Jun 2023 18:21:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687126874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=KnvewLEAbpl6Zh6vL0c6mhjRAU42VrGnfWPQDY+DN4A=;
 b=ElVzkchCZ24deqhO0/Gwg8OQJA20zxVBaANVLQD2LGLZQsUb39WpJedvsrk1JMXUIeGMJY
 Y3LlwjCflSkj/V9GBWpXcu+Sk4JyDjGpk2leWPEIHL2zHGP6LUuhMVakhjOhsSv/NZ2deu
 JjF80FVnwS7WEzUitzQ1BQCtTa0ejHc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-0RGJUY4vMvSonEjiOHdcPA-1; Sun, 18 Jun 2023 18:21:13 -0400
X-MC-Unique: 0RGJUY4vMvSonEjiOHdcPA-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5147e3dfccdso1503906a12.1
 for <qemu-devel@nongnu.org>; Sun, 18 Jun 2023 15:21:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687126872; x=1689718872;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KnvewLEAbpl6Zh6vL0c6mhjRAU42VrGnfWPQDY+DN4A=;
 b=FPiRLXg/xrDRHZKiCHIR+g4dvZUK9shyfx+CQhTAWj+qt7prcn4VWQ2vlSKXGEOYHe
 lsXZNQTt5hv8UjG5E0efqHCI7F6K0p8Og6FbyZ99EceQNo62O8zHFC9CVh3eSBabeZh/
 uZiK1w4T1isgcUAYdWElWarpcx5TXse2P2f3JrF+me4JJJFYFw3BAxgB36x+N6SkaAj0
 21dyiL/RgmzfKxmoftLLCHZRp3gNb7x+gIL7zZE5AKrZmrgUyjro/Nmavc87PLwyGs43
 +yI2jYK1ehjVRvBj9ql9VsNZZSXUTaBTaOhXMeuft1ne6cey0PgkflYjfsfwoezvaMXN
 corw==
X-Gm-Message-State: AC+VfDxV/qs+osgW5xtp2KlJKazUaXEKFCTMZopajrNlr41DapHOTgVw
 bU7Pl2bEFsqhMukh51FIhBv2LY8RSULCW78pxXWlhFgvs6m1oIEdTmBAz/+H1dH2vsczoD9nVnf
 6/xYcO/zZR/SXVpKtzkvvlpI8bFytXZzX4D2OW+sPTs8DJiRcIEmhuFmiykeE7dyXCrO8Oeizf9
 EwJg==
X-Received: by 2002:a05:6402:88e:b0:514:7f39:aa80 with SMTP id
 e14-20020a056402088e00b005147f39aa80mr4882585edy.18.1687126871845; 
 Sun, 18 Jun 2023 15:21:11 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7FGgI/aOktdrKqIRmU0dO+eJmiuoxOIbB6sQ8AijWreBiXAMSXz3TH8aLBViCGqc7qslyORw==
X-Received: by 2002:a05:6402:88e:b0:514:7f39:aa80 with SMTP id
 e14-20020a056402088e00b005147f39aa80mr4882579edy.18.1687126871484; 
 Sun, 18 Jun 2023 15:21:11 -0700 (PDT)
Received: from [192.168.60.219] (server.hotelpassage.eu. [88.146.207.194])
 by smtp.gmail.com with ESMTPSA id
 e21-20020a056402149500b0051a1ef536c9sm4563371edv.64.2023.06.18.15.21.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jun 2023 15:21:10 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] target/i386: allow using named CPU modeles with user mode
 emulation
Date: Mon, 19 Jun 2023 00:21:07 +0200
Message-Id: <20230618222109.110843-1-pbonzini@redhat.com>
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

When running qemu-i386 even with -cpu Nehalem (aka x86_64-v2), it raises the
warning

  TCG doesn't support requested feature: CPUID.80000001H:EDX.lm [bit 29]

Likewise using qemu-x86_64 with -cpu Haswell, it raises warnings for

  TCG doesn't support requested feature: CPUID.01H:ECX.pcid [bit 17]
  TCG doesn't support requested feature: CPUID.01H:ECX.x2apic [bit 21]
  TCG doesn't support requested feature: CPUID.01H:ECX.tsc-deadline [bit 24]
  TCG doesn't support requested feature: CPUID.07H:EBX.invpcid [bit 10]

Even though x86_64-v3 is the level that qemu-user is supposed to provide.
These are two related problems:

- for Haswell, the 4 missing features are only relevant to code running
  in kernel mode; we can ignore them and mark them as supported even
  though they are not.  The supported features are only used to print
  the warnings

- for qemu-i386, the issue is that the i386 target is not about running
  programs on a 32-bit processor, but rather running programs using the
  32-bit kernel ABI on any processor; the behavior of the processor in
  compatibility (32-bit) mode is independent of the LM feature.  Therefore,
  LM can also be treated as a feature that is only relevant in kernel
  mode.

Other CPU models have warnings for the ARCH_CAPABILITIES MSR; hide
them as well in a similar manner.

Based-on: <20230618215114.107337-1-pbonzini@redhat.com>

Paolo Bonzini (2):
  target/i386: ignore ARCH_CAPABILITIES features in user mode emulation
  target/i386: ignore CPL0-specific features in user mode emulation

 target/i386/cpu.c | 95 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 86 insertions(+), 9 deletions(-)

-- 
2.40.1


