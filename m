Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FBB7F0049
	for <lists+qemu-devel@lfdr.de>; Sat, 18 Nov 2023 16:27:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r4NCO-0003KY-00; Sat, 18 Nov 2023 10:25:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1r4NC2-0003JD-WF
 for qemu-devel@nongnu.org; Sat, 18 Nov 2023 10:25:11 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1r4NBz-0007n4-SP
 for qemu-devel@nongnu.org; Sat, 18 Nov 2023 10:25:10 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1ce5e65ba37so11037815ad.1
 for <qemu-devel@nongnu.org>; Sat, 18 Nov 2023 07:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1700320983; x=1700925783;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fSQek2lpeSbE9lzF9DLJymqmxalZ58pd3L6W172GqRg=;
 b=apVpr+OXv3PTc5JqZzt5IQpb+igRdUlyqoheP8dIq8MSbqhF29IzCC1qJX/R/nltZ8
 Ocdw1j5bFejuIP9X0kyFElkOMApncpK0RI0MAwMqrpP51tGPLeVSF4InNyWChEU53rHs
 /rV0deQLwa2m4sMvpMTIFJtw3m945yxP+xj56nB4fiyHIbVUgpgSZK/EiNwzsa8Ql2SZ
 iSuzrAbP3egthWyrTeglG3dZPiZchg6m5Z2SQLMGk0Zh/QgR2w1iodaoeEOVfcSxIy5x
 Cuo+kEFsiPEDhhntM5SwC4ye2RM3X4tR302O4LFQgpQpSJDBo2BxoVJUcGuLi+C2Oh02
 fO9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700320983; x=1700925783;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fSQek2lpeSbE9lzF9DLJymqmxalZ58pd3L6W172GqRg=;
 b=hfFkIjqMjEl5DnIHO8mxMD5IPsgujzVaqhKUSsl12TJn6PA7Lu9n3YHish4TYdrvPl
 vir0OuqFZMCIb+Wm+4cpVnqhZqZB6amSmCzx60+01VEAnYcJe6prOevXVVqOU0/k6QEu
 9Y3xCnLX92MnGnTXHRvuYqHUOBmfa9dQNnHp4NHK9nw0v529f7nhTyUediOLehNgQ/Km
 tJ61nfKY+AdRIyJabXoNA3JIscYCE0x3T8JjTczJ5DhF9LPoi7AiPzNjsNDOYnGUe7yk
 P79n9WbM1bMZCbVMD0vqxPcKpDEPFbQVbaptdgd6ngibRZ5nCmVBJI/st7WeKe2ViYwF
 aaSQ==
X-Gm-Message-State: AOJu0YxNKbEmNwZJBJksD9C6lUS7abfQJwPBJiGqjtFsGwxkE6zVLQuO
 26TUenly791zU2/g5VKmQBrJbAkfkX3YeNN2KHJ9OQ==
X-Google-Smtp-Source: AGHT+IFkFsZQiN39zheGqaM4I00Xbw9kzHSiav7SnUDTdl8VqglLEhsihR647Q4K9WrG4/TAk1tF5Q==
X-Received: by 2002:a17:902:ed15:b0:1cf:530b:d027 with SMTP id
 b21-20020a170902ed1500b001cf530bd027mr2008821pld.15.1700320983006; 
 Sat, 18 Nov 2023 07:23:03 -0800 (PST)
Received: from localhost.localdomain ([125.71.94.124])
 by smtp.gmail.com with ESMTPSA id
 f2-20020a170902ce8200b001bbb25dd3a7sm3120884plg.187.2023.11.18.07.22.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Nov 2023 07:23:02 -0800 (PST)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Hyman Huang <yong.huang@smartx.com>
Subject: [v2 0/2] vhost-user-test: Add negotiated features check 
Date: Sat, 18 Nov 2023 23:22:48 +0800
Message-Id: <cover.1700319559.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62f;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Markus made suggestions for the changes to version 2, and thanks
for that as well.

v2:
- rebase on master.
- drop the "show-bits" option. 
- refine the comment.


v1:
The patchset "Fix the virtio features negotiation flaw" fix a
vhost-user negotiation flaw:
c9bdc449f9 vhost-user: Fix the virtio features negotiation flaw
bebcac052a vhost-user: Refactor the chr_closed_bh
937b7d96e4 vhost-user: Refactor vhost acked features saving

While the test case remain unmerged, the detail reference:
https://lore.kernel.org/qemu-devel/cover.1667232396.git.huangy81@chinatelecom.cn/

Since Michael pointed out that the info virtio makes sense to query
the negotiation feature, this patchset uses the x-query-virtio-status
to retrieve the features instead of exporting netdev capabilities and
information as we did in the previous patchset to aid in confirming
the negotiation's validity.

To do that, we first introduce an "show-bits" argument for
x-query-virtio-status such that the feature bits can be used
directly, and then implement the test case for negotiated features
check. As we post, the code is divided into two patches.

Please review, thanks,
Yong

Hyman Huang (2):
  qapi/virtio: Add feature and status bits for x-query-virtio-status
  vhost-user-test: Add negotiated features check

 hw/virtio/virtio-qmp.c        |   8 +++
 qapi/virtio.json              |  37 +++++++++++++
 tests/qtest/vhost-user-test.c | 100 ++++++++++++++++++++++++++++++++++
 3 files changed, 145 insertions(+)

-- 
2.39.1


