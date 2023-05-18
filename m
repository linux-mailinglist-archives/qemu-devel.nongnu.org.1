Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C20F707A15
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 08:11:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzWr8-0008I2-Uf; Thu, 18 May 2023 02:11:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1pzWr5-0008HZ-E8
 for qemu-devel@nongnu.org; Thu, 18 May 2023 02:11:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1pzWr2-000515-L2
 for qemu-devel@nongnu.org; Thu, 18 May 2023 02:11:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684390271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=POs/BQVMoivQyUmVNZMcRuw6DgTlBBQIOum/ugrzyF8=;
 b=P2zMJ0Io/1bXkJGu43fL0yP1l/0anyDteWQEbjoEq7qp0TG4MLs4t1b1SOsHsk1w2Fb9GT
 vMXJtjYH62imwYR154ILz0g+UJy8/YYi7kYBRzkGMMNwNoGY7/rH/WVTmdAdKnMQ4vfPr3
 gyjbv+nKDmjv5YyHueDPi1hExxXqZPc=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-lHXXySt-N66y2oMyNmeT0g-1; Thu, 18 May 2023 02:11:09 -0400
X-MC-Unique: lHXXySt-N66y2oMyNmeT0g-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-64d2467d593so23515b3a.0
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 23:11:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684390269; x=1686982269;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=POs/BQVMoivQyUmVNZMcRuw6DgTlBBQIOum/ugrzyF8=;
 b=cZJVsqh31jkYh8zYJgrUIw/v1rhxvYVRV53QLvnY3Ke99PCBRlhAj3v1ok+oB0D2BQ
 SC3W8oyC48LoC8kKULryAG6VGqzbo6xHyvrarzgvqMglB/Z+PnXJ6CcSJg4bkxCoeQVf
 mgSuOKJkpGojUN5LpfXrPQUBRiDQDb/DGJ7GHRWMaIani9hz5usYIhDPQXcCi3q+VsJH
 rG8rg/kAhSX59D7NYl0yzj5S0D0KnYuqJzWXCK1KJE8JYcokizAXkFShjIBr7Up9u9QZ
 bbJ/PJqijHMgB8c9QY3x8RwwT+RclSiLWKOMcqoB2tWgJqWCitbrE+8PM5ddg+MPeKDi
 ANgA==
X-Gm-Message-State: AC+VfDxXOAOXU/oUZ71EKN8Rv4X4oAjC2z2YRhQXiWuChTuiksLqfmHt
 uDEiGiDhEpRRfP5K0CstkXxGGWnfipe4L29CJy/qxMoHIlI74CGdFKpyWRDbaaam9hQN22LUer6
 1YBXs3+PoeSNcus4=
X-Received: by 2002:a05:6a00:1785:b0:64a:f730:154c with SMTP id
 s5-20020a056a00178500b0064af730154cmr3287159pfg.13.1684390268901; 
 Wed, 17 May 2023 23:11:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5KW60xfM8iR5ZGijy5kczLdRz/3d0RuyCnphXSI1VuiLzU4pCOJgvRyb9Z/RFMKJJfisoQCg==
X-Received: by 2002:a05:6a00:1785:b0:64a:f730:154c with SMTP id
 s5-20020a056a00178500b0064af730154cmr3287140pfg.13.1684390268609; 
 Wed, 17 May 2023 23:11:08 -0700 (PDT)
Received: from smtpclient.apple ([115.96.106.170])
 by smtp.gmail.com with ESMTPSA id
 23-20020a631457000000b00530277f7b0fsm452228pgu.53.2023.05.17.23.11.06
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 17 May 2023 23:11:08 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH] acpi/tests/bios-tables-test: add an environment variable
 for iasl location
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <87ilcqnckm.fsf@linaro.org>
Date: Thu, 18 May 2023 11:41:04 +0530
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <BB60D504-C69A-4984-A078-A3899B38DE58@redhat.com>
References: <20230517120751.14679-1-anisinha@redhat.com>
 <20230517101523-mutt-send-email-mst@kernel.org>
 <B6AD0FB1-CF05-4B4C-B58D-279422895E4D@redhat.com>
 <20230517103522-mutt-send-email-mst@kernel.org>
 <ED522229-5A71-40C2-AF2C-5D921B0B5D54@redhat.com> <87zg63m18g.fsf@linaro.org>
 <20230517112347-mutt-send-email-mst@kernel.org> <87r0rflzd4.fsf@linaro.org>
 <20230517120710-mutt-send-email-mst@kernel.org> <87ilcqnckm.fsf@linaro.org>
To: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
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



> On 17-May-2023, at 9:50 PM, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>=20
> is there any easy way to add arguments to individual tests

I looked at this before for bios bits work and seems it is not =
straightforward to add test specific command line options in our meson =
build system. It needs some work. I am also curious as to what Paolo =
thought about this.=


