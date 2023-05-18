Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E35707DE0
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 12:18:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzai6-0007C9-2g; Thu, 18 May 2023 06:18:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzai3-0007BU-Lf
 for qemu-devel@nongnu.org; Thu, 18 May 2023 06:18:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzai2-0004kz-8c
 for qemu-devel@nongnu.org; Thu, 18 May 2023 06:18:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684405089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=FMGAp67pCzRERc/50dq+8XPU465P8/s9qIpLz/s8cTo=;
 b=Omc3MQ2nafck0qRO/u7gIXyV/a7Kem+wDKbnmO2+C0Z49XJmaoWH9Q993OEnaFLtRxhMbb
 wIcDxTiMcrZFW6tI/mk3wnvzgISuJn8S+uA9vRydduP5Wb5t4XTW5SAHIP5nVYRy/MYreG
 Oazd9ytCBk/vxALEomeWyyC19qyc3D4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-5c5l3G4sNFK-Ow0xj1zFGw-1; Thu, 18 May 2023 06:18:07 -0400
X-MC-Unique: 5c5l3G4sNFK-Ow0xj1zFGw-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-510526d2a5fso2270096a12.0
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 03:18:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684405086; x=1686997086;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FMGAp67pCzRERc/50dq+8XPU465P8/s9qIpLz/s8cTo=;
 b=OPKfF+JhbgF9+JbCf8g+wyrqTf+L+aqsfryNt2yRaJdfJ80w5mkI/ruIbKgpSPENJV
 hNRIWMYPlQ4x51hWCJTuQU/KzK4OEkgzpp1zW2A16s7zcU3ZB1VrYcaKU4v1wa80ZVIV
 EumQT7tAcRzGnV3d/m0vIGizfEtKvcjxulJW8L7/B0nC2+qFFDwgSRL8HiAljdrK8ejt
 3rMAAx9YWlaDYZvlHvLN3t1GRLNTrzCIUwWKo1GVNiXzA1h8eOjN8BZhavUO5Z5LB99x
 IHHEOpHohdoxkn5XcoLlwbUuJQBW2vW/KvR2DJKBREnaX9JLOPlELMNfDe67/wssUabv
 zwkw==
X-Gm-Message-State: AC+VfDyOEYdTfVrxUNv219rITiU2OJpn+AwI+RmA6/fJAqYh7YRdczkZ
 XalfAwybivswgyeZwVirHBVbQvlNhfVN7YQILHcSWnHXUDd046xTPHfLHhILw82FWNFwDlGGMwl
 n/2wFIkkv/CVPdMoUXMaD7qME70hnskJDIoC0GQq6wTxUud0jBZwaFUAL/6FyDICPRqAghFl7/A
 I=
X-Received: by 2002:a17:907:96a1:b0:94f:236b:9e3a with SMTP id
 hd33-20020a17090796a100b0094f236b9e3amr5148959ejc.3.1684405086273; 
 Thu, 18 May 2023 03:18:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5gdfD5MhY1vx3PIMHDshik1iq8vXLX+VV/6Cpta8HcEZtUnsTWdqvufOKpFtDb0N4+Q9moDQ==
X-Received: by 2002:a17:907:96a1:b0:94f:236b:9e3a with SMTP id
 hd33-20020a17090796a100b0094f236b9e3amr5148943ejc.3.1684405085922; 
 Thu, 18 May 2023 03:18:05 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 cd20-20020a170906b35400b0096a5eb2836asm758346ejb.203.2023.05.18.03.18.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 03:18:05 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com
Subject: [PATCH 0/4] monitor/hmp: cleanup monitor_event() and suspend_cnt
Date: Thu, 18 May 2023 12:18:00 +0200
Message-Id: <20230518101804.992085-1-pbonzini@redhat.com>
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

monitor_event() is not using monitor_suspend() and monitor_resume()
even though that is the desired outcome of moving out of and back into
the monitor with Ctrl-a c.

While cleaning this up, make the locking of several fields in struct
Monitor less esoteric, i.e. protect them just with mon_lock.  This gets
rid of one of the last two cases where qatomic_mb_read()/qatomic_mb_set()
pair is used to achieve a semblance of sequential consistency.

Paolo

Paolo Bonzini (4):
  monitor: use QEMU_LOCK_GUARD a bit more
  monitor: allow calling monitor_resume under mon_lock
  monitor: add more *_locked() functions
  monitor: do not use mb_read/mb_set for suspend_cnt

 include/monitor/monitor.h     |  3 +++
 monitor/hmp.c                 | 41 ++++++++++++++++-------------------
 monitor/monitor-internal.h    |  3 +--
 monitor/monitor.c             | 39 ++++++++++++++++++---------------
 tests/qemu-iotests/051.out    |  4 ++--
 tests/qemu-iotests/051.pc.out | 20 ++++++++---------
 6 files changed, 57 insertions(+), 53 deletions(-)

-- 
2.40.1


