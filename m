Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A48EC705E97
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 06:13:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz8Ws-0006Lt-FY; Wed, 17 May 2023 00:12:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1pz8Wf-0006LZ-8J
 for qemu-devel@nongnu.org; Wed, 17 May 2023 00:12:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1pz8Wd-0004mq-Tp
 for qemu-devel@nongnu.org; Wed, 17 May 2023 00:12:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684296750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=1sKMjNjTmo/jzvDmPuWtjhv+Cn28RLJQsDu8PLMYKAU=;
 b=HMq9AY43RBmpTdJHzb2LLXBdS+Hy38ByYx4RFARNJWQClRkEj+7jxEmXukDbJSLATq2X84
 pCC4SZW1cJS30d7U/c8HYZdz1yd/i35DwuYmKADeakH/nYmldzRLYQi1hIFrAWw0U2Uu0X
 ijU6b5jHeLeDctXdf0pmXwSYhMGcyZA=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-UhNKKaHDOQaQIYxo9baLZg-1; Wed, 17 May 2023 00:12:28 -0400
X-MC-Unique: UhNKKaHDOQaQIYxo9baLZg-1
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-1ab032d91a1so2741855ad.1
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 21:12:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684296748; x=1686888748;
 h=to:cc:date:message-id:subject:mime-version
 :content-transfer-encoding:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1sKMjNjTmo/jzvDmPuWtjhv+Cn28RLJQsDu8PLMYKAU=;
 b=jnPZ5sFFgrY26UU4lbKltbRwOgGOMJ1in0lRDpyoTGcrPQRRx/DvMAzglrrtEHjN9z
 S1xh3A+6cQdhFuwQlnz0TEQsCVGV2qohO8CAaw9Tno1dVxQFm1EzU1t/1qTDzRqB+IQm
 DfP6yrm3ymRA7OpG6R2lduWjx3lPMlk4rtfwNDppsEZ3Cg87WnrEnpUoZ+lUhRa5fm5C
 9Wa4Itrw4z9SgMgW+jaLzAPJiD5HlkAN0MoIo89gQtq5ZpeJW71RufxEMoDquXe91lLT
 Sf5wlydsfBY4E+XdLzugt9st5l4oAPPcoGzOz9Hm6rPjUhlGNV4qyxgFKh0qvVlXl1KA
 AjIg==
X-Gm-Message-State: AC+VfDywNVpx+4ZLEowSsaZSsZoTXse+iWH1wLgvWdmCjtAmCdHgZ02l
 wZxLP0WgTclkyuapXbJ1naBTC+tOhYdipHTraqH8M+sDwCHWjwE16HY6yLgjDuejy2rScK4WiJ4
 shH+3Bv9A7x38xhw=
X-Received: by 2002:a17:902:c40b:b0:1aa:fd48:f5e2 with SMTP id
 k11-20020a170902c40b00b001aafd48f5e2mr53032581plk.32.1684296747772; 
 Tue, 16 May 2023 21:12:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ71dajCNgrZuuhTHyWxp5BoSR2fESHNVRQlSupj9+3zobb7iC+r5GftjpbFrehsIihKKOelCw==
X-Received: by 2002:a17:902:c40b:b0:1aa:fd48:f5e2 with SMTP id
 k11-20020a170902c40b00b001aafd48f5e2mr53032562plk.32.1684296747483; 
 Tue, 16 May 2023 21:12:27 -0700 (PDT)
Received: from smtpclient.apple ([115.96.105.155])
 by smtp.gmail.com with ESMTPSA id
 g30-20020a63201e000000b0052858b41008sm14300588pgg.87.2023.05.16.21.12.25
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 May 2023 21:12:27 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: bios-tables-test and iasl
Message-Id: <21AAB986-4A82-48DB-B0FF-7887C9F38EBC@redhat.com>
Date: Wed, 17 May 2023 09:42:23 +0530
Cc: qemu-devel@nongnu.org
To: Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
X-Mailer: Apple Mail (2.3696.120.41.1.3)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
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

So I was working late scratching my head yesterday on why I was not =
getting my ASL diff on mismatched blobs! Turns out there were two =
things:

(a) iasl was not installed and I completely forgot about it because my =
old setup is gone and the new box is, well new and I did not get to mess =
around with tables up until now. This was easy to figure out.
(b) I recalled that previously all I had to do was install iasl and the =
binary would just produce the diff because it would discover iasl was in =
the PATH. Now it seemed no matter what I did I was not able to get the =
diff until I rebased and it triggered a clean build of qemu tree. Turns =
out, now we check iasl existence from meson and CONFIG_IASL is set from =
the build time (if not set, *iasl is NULL and no diff is generated).

So I wonder if we have made our lives any easier? Why should we need to =
rebuild the entire tree if all we wanted was to debug a test breakage? =
Sure we could always run iasl manually but isn=E2=80=99t it easier to =
simply run "V=3D1 make check-qtest=E2=80=9D and let the test spit it out =
for us?

A=


