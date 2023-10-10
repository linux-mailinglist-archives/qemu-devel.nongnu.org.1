Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3557BF82E
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 12:04:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq9aY-0006sk-44; Tue, 10 Oct 2023 06:03:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qq9aV-0006rm-Nw
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 06:03:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qq9aU-0006Ql-Ap
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 06:03:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696932217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H8QCDL2YPCfJjIjG+t0h9Wcrjm6l5oi6SXDyDrL/uMw=;
 b=fiK8Rqq5I/jOLdaPaeKsU0c/wnX/pLa4qzHLBn03A26EdBv/uOkLxsfTdsTahYl2VwHEBt
 g4Uiy2mK2r5Xv0/kp/uzEAPzBi/VSb4FTveseRBxDIREKeMPvXjrpddDpgdLDwU6vtJcAC
 JZBl+6c6IxSKRtZWGfXloh9mdMTSwno=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-5UdOrQP4PKmWtOzAULhmCg-1; Tue, 10 Oct 2023 06:03:36 -0400
X-MC-Unique: 5UdOrQP4PKmWtOzAULhmCg-1
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-3af6a12b2a8so9743204b6e.1
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 03:03:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696932215; x=1697537015;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H8QCDL2YPCfJjIjG+t0h9Wcrjm6l5oi6SXDyDrL/uMw=;
 b=j90WsmeWcO+Rc4vqnmihndKqYzG1NO3ICTT4gqRTbKkw+CL9gk1S1bHGIn88o2AQUC
 UvX1CT+3fjNE34NCpegkjCAHMNFRuDsfK6G9qJsHHeJFH/NdRqsTf5+civAzyajMymko
 At4jPIfNE8FehPPtdbDdPcr7nb9lTGqUXkJbp8KQDU9Tx1tY60wgRQPuhc3JInSUXYgU
 1h7UdhMfFqhp8mo/fdwtpJ3LgdCjtiy/Bxvlq957gPRfk07ReIF97/Sdz2R4OV+FlmXs
 xKwu/yaWIJu85+k3Pd5uol+5xS+vUqZn906CQNOVmaBpG9NU9ozaVCi+M4lki0GzzeCr
 qHTw==
X-Gm-Message-State: AOJu0YyKRo1k5ucvcvXI0qOMLR0/LIzJHWDSrDrJ+JL/UjDjCQ0w33On
 KdIrkEPWg7w986foa2fzw6UHZuUP5OFi8dvggbklurX5wP69XEVpcCAENAkCthHLBbgtYG70dbN
 jLF7/xaa4aeQpPbg=
X-Received: by 2002:a05:6808:200e:b0:3a7:5b1d:9470 with SMTP id
 q14-20020a056808200e00b003a75b1d9470mr23487455oiw.53.1696932215709; 
 Tue, 10 Oct 2023 03:03:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFY0WWReEHP/N6FHJAHtmv6QenNWdLIa0lcYPIR3uw4PSk/u67vt8cq5WPriPocyLLoqIo+UA==
X-Received: by 2002:a05:6808:200e:b0:3a7:5b1d:9470 with SMTP id
 q14-20020a056808200e00b003a75b1d9470mr23487418oiw.53.1696932215424; 
 Tue, 10 Oct 2023 03:03:35 -0700 (PDT)
Received: from smtpclient.apple ([115.96.109.49])
 by smtp.gmail.com with ESMTPSA id
 u24-20020a63b558000000b00577d53c50f7sm9609618pgo.75.2023.10.10.03.03.31
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 10 Oct 2023 03:03:35 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Re: [PATCH 2/4] tests/qtest: Use qtest_get_arch_bits()
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <d69ced42-5fba-8dcc-5137-2fa95b97482e@redhat.com>
Date: Tue, 10 Oct 2023 15:33:29 +0530
Cc: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, qemu-block@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2138A1A4-082C-42B9-ACD1-C1BE9D715EF3@redhat.com>
References: <20231010074952.79165-1-philmd@linaro.org>
 <20231010074952.79165-3-philmd@linaro.org>
 <d69ced42-5fba-8dcc-5137-2fa95b97482e@redhat.com>
To: Thomas Huth <thuth@redhat.com>
X-Mailer: Apple Mail (2.3696.120.41.1.4)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



> On 10-Oct-2023, at 3:19 PM, Thomas Huth <thuth@redhat.com> wrote:
>=20
> On 10/10/2023 09.49, Philippe Mathieu-Daud=C3=A9 wrote:
>=20
> Some short patch description, please! Why is this necessary/useful?
> (I think I know, but other might not, and it is also important for the =
history)

Other than this,
Reviewed-by: Ani Sinha <anisinha@redhat.com>

>=20
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>> ---
>>  tests/qtest/arm-cpu-features.c | 49 =
++++++++++++++++------------------
>>  tests/qtest/bios-tables-test.c | 16 +++++------
>>  2 files changed, 30 insertions(+), 35 deletions(-)
>=20
> Thomas
>=20


