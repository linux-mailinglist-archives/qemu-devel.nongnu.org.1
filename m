Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5563C74554D
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 08:09:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGCkC-0000s4-4d; Mon, 03 Jul 2023 02:09:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qGCkA-0000rv-Qr
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 02:09:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qGCk9-0006sy-FE
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 02:09:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688364540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1VA5mUwWt01msFPuB0WddeWe8wcOyuYVYkSbIMrokfU=;
 b=DGsA4KjwJfjYeDDlRDrohyplGNzwckEWwbqWvr+VfQwaiHQ+mYlAfqAfxmCTfZGrFxMAkL
 TPHDbSoMfT7WGfSOYKncCvmd1oJZ46EXeHVSwIPEujXB0bmJpBLEVHeKXBF6wJeQttQD+F
 7EloojuLh8em2m49Hh0yLFuyJ0gLbJI=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-D6mdeNZpMUquHvYCWHMANg-1; Mon, 03 Jul 2023 02:08:59 -0400
X-MC-Unique: D6mdeNZpMUquHvYCWHMANg-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-553d42a7069so5556489a12.1
 for <qemu-devel@nongnu.org>; Sun, 02 Jul 2023 23:08:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688364538; x=1690956538;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1VA5mUwWt01msFPuB0WddeWe8wcOyuYVYkSbIMrokfU=;
 b=QGH5UZDza0QG2O9L+CvgWJaFSe2sn/HdkYXqHLA5EwyArO+bIx3mMLw3er2rfiQS63
 GtqbiVeRGEBXPMJxwx6i0u9ePtcd4h9MWWXZCPgvN2+LqV+2xIi2TjTOcBfi03i0VJ/V
 dRokR/qSfph/9CTlbA4D1BOEIb/xWaD1wUZl5Kw8Vb0ktbLlg+V8g02HM6oI5Rx4zezI
 8zzvPkI7jmCb9hOylyiwsWp2TfTj4LdKE8wZG9KP+0OuT1J4qUvmpFakCPukilWuIxPY
 AIouqepG/1Oygq/uxxv52YP5cKgTsmXxkC+Q1iuc0JCnFZUeOYh1bG4jdBoG9I2SAgsW
 JGAA==
X-Gm-Message-State: ABy/qLYeQiUv3qdUhwh6FuLfOxtrCvuv3zYkEIvt0lSQhEZrNPKx4Eko
 0Nra8I6ARJ60EQHUADFOlk72VwFgB6COdcyQoAna5TQCVEfwkfDI/lJUKFCtoG+AqRzADZsWeO5
 OdRImE23FOvaQPPw=
X-Received: by 2002:a05:6a20:3c87:b0:12e:b2e6:5782 with SMTP id
 b7-20020a056a203c8700b0012eb2e65782mr1546011pzj.53.1688364538030; 
 Sun, 02 Jul 2023 23:08:58 -0700 (PDT)
X-Google-Smtp-Source: APBJJlExZh8ZBPYn4hiEgkO6z9RCZ0aEFrHBw6Y2J0kaiMp415zY98KaMKeFgBMvKwTq1PkxGDH0JQ==
X-Received: by 2002:a05:6a20:3c87:b0:12e:b2e6:5782 with SMTP id
 b7-20020a056a203c8700b0012eb2e65782mr1545982pzj.53.1688364537576; 
 Sun, 02 Jul 2023 23:08:57 -0700 (PDT)
Received: from smtpclient.apple ([203.212.242.239])
 by smtp.gmail.com with ESMTPSA id
 g23-20020a62e317000000b00679b7d2bd57sm10664021pfh.192.2023.07.02.23.08.54
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 02 Jul 2023 23:08:56 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH v6 5/5] hw/pci: ensure PCIE devices are plugged into only
 slot 0 of PCIE port
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20230702005916-mutt-send-email-mst@kernel.org>
Date: Mon, 3 Jul 2023 11:38:47 +0530
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Julia Suvorova <jusual@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <63B46F8F-A52C-4BFC-BAFD-06ACAF2AA6E1@redhat.com>
References: <20230630041937-mutt-send-email-mst@kernel.org>
 <4618EAD1-2862-4288-A881-CA860D04ADB0@redhat.com>
 <20230630043734-mutt-send-email-mst@kernel.org>
 <49B901C6-4819-4A00-8225-39FAA6678F3E@redhat.com>
 <20230630055717-mutt-send-email-mst@kernel.org>
 <FB764864-ADD3-4017-8313-ED40A833A81B@redhat.com>
 <a38e0336-58e5-e796-bd29-0dfc5d1d0e46@daynix.com>
 <bf351f8b-1c8a-8a7a-7f44-17c9ba18f179@daynix.com>
 <DFB3B0B7-1F61-4779-9833-2AF1BA3BDFA6@redhat.com>
 <2ffee496-ec63-ad04-a90b-8c2fadbf3657@daynix.com>
 <20230702005916-mutt-send-email-mst@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mailer: Apple Mail (2.3696.120.41.1.3)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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



> On 02-Jul-2023, at 10:29 AM, Michael S. Tsirkin <mst@redhat.com> =
wrote:
>=20
> On Sat, Jul 01, 2023 at 04:09:31PM +0900, Akihiko Odaki wrote:
>> Yes, I want the slot number restriction to be enforced. If it worries =
you
>> too much for regressions, you may implement it as a warning first and =
then
>> turn it a hard error when the next development phase starts.
>=20
> That's not a bad idea.

If we had not enforced the check strongly, the tests that we fixed would =
not get noticed.=


