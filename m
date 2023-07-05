Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A79674894D
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 18:36:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH5TM-0001d7-OV; Wed, 05 Jul 2023 12:35:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qH5TF-0001W2-Cm
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 12:35:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qH5TD-0003bv-P4
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 12:35:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688574911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MSPRyQuTpTDUJYT7EH8vGfPwFDbvOPj0S0nnbP7Wtyw=;
 b=SA53UQYhhQ0BF66QHhwLQ2jNucJ/bb/ewZ4l/atAWN6kTSEC0nJwfc3/6/hQno/AMdAvLV
 JZB6k37C6fo+/tbP6zj6HAF5cL+OrwvGkZkIcK3JE5h9dscY6QmVIpzL30aicNjRheNzAi
 PhRCMd8cWS0zE4uOwH/Sn6GxPUY0hdw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-n0QkSvQWP7S_s4RRZ0iNQw-1; Wed, 05 Jul 2023 12:35:09 -0400
X-MC-Unique: n0QkSvQWP7S_s4RRZ0iNQw-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7672918d8a4so198144885a.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 09:35:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688574909; x=1691166909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MSPRyQuTpTDUJYT7EH8vGfPwFDbvOPj0S0nnbP7Wtyw=;
 b=HIYl/g0ig4W9uNHtLu7xOBHPSzmq3T4Mfv4oSFoyKHmateQkfBOz6t7kc8BS7bdG+t
 qfhPzE/JjKkV/2BoCTjLFU/oRm7G5e8U7Qu19p7MsYClzd+U+y4H7AnrMig+MVjsAOfp
 IVSOzvyRs/S3jgFYFhbvyn0ERTzoWk3KWJWyFbd4gNM1uzGPAEJkEGvfq24hODhg8RD4
 NSo0COXb1I7xjwgDwWvMGRbrc3nkzg6dhwtGu70lPRPdzW0RxEHcho8rjNlf+bGT+UOg
 548iqpNfp4CjfwnWwqQvht7LdE1Z2P07aMzZsRLoKDQKiDrFInkj2L7OCuNi07ZwXJFR
 k0yQ==
X-Gm-Message-State: AC+VfDy8d5TQW+QIa3PrY8HySDX6m+yXyZIScB+ueXp/sKHSRvsLUcPa
 3dD2if7iCqWUG8DmPSNrqHV2M62yxZVcEJ2DL4QLvC1pgUdyAeVU7DN3xkDKlq/sBNKdG/jIZFk
 mN0HhGq+A2OYlp6l4A1NUtCIgsSc0yNmz8eZr5GS3BAKOEJ6kE41FwhdcljBkagTFJldh5LCz
X-Received: by 2002:a05:620a:44c6:b0:766:f972:73da with SMTP id
 y6-20020a05620a44c600b00766f97273damr24200313qkp.1.1688574909098; 
 Wed, 05 Jul 2023 09:35:09 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5x4eoFVlILNzJjnW34vKlEWGV3wIAKVD3qvfbWZpj2qwggtiGDDtu58vokIPoY9exYZw5FbQ==
X-Received: by 2002:a05:620a:44c6:b0:766:f972:73da with SMTP id
 y6-20020a05620a44c600b00766f97273damr24200269qkp.1.1688574908663; 
 Wed, 05 Jul 2023 09:35:08 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 x19-20020a05620a12b300b007620b03ee65sm6760094qki.37.2023.07.05.09.35.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jul 2023 09:35:08 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Juan Quintela <quintela@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, Laszlo Ersek <lersek@redhat.com>,
 peterx@redhat.com
Subject: [PATCH v2 5/7] migration: Deliver return path file error to migrate
 state too
Date: Wed,  5 Jul 2023 12:35:00 -0400
Message-ID: <20230705163502.331007-6-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705163502.331007-1-peterx@redhat.com>
References: <20230705163502.331007-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

We've already did this for most of the return path thread errors, but not
yet for the IO errors happened on the return path qemufile.  Do that too.

Remember to reset "err" always, because the ownership is not us anymore,
otherwise we're prone to use-after-free later after recovered.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index 46dbfb07c4..8f60de362f 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2008,6 +2008,13 @@ out:
 
     res = qemu_file_get_error(rp);
     if (res) {
+        /* We have forwarded any error in "err" already, reuse "error" */
+        assert(err == NULL);
+        /* Try to deliver this file error to migration state */
+        qemu_file_get_error_obj(rp, &err);
+        migrate_set_error(ms, err);
+        err = NULL;
+
         if (res && migration_in_postcopy()) {
             /*
              * Maybe there is something we can do: it looks like a
-- 
2.41.0


