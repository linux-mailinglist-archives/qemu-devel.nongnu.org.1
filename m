Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D65B370867F
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 19:14:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzhBO-0006QF-UO; Thu, 18 May 2023 13:12:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1pzhBM-0006Q5-QB
 for qemu-devel@nongnu.org; Thu, 18 May 2023 13:12:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1pzhBK-0000Pv-KG
 for qemu-devel@nongnu.org; Thu, 18 May 2023 13:12:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684429969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l2vyHlKeWqUZbPd7XzbAiQoZNXRMWHkABUYYxs/lXFs=;
 b=HT9BaoO/uMDAm4elOnL2xgj9IWUo+eOEQnNaCIZvc/eDQVZHHEmDvdtY/5xXXXYu7/cIGp
 B1tjU38jVLY2fJHvV3hPiazBtknyUXTFoLp3hyg342bt5HbJlgSnFc3C1eWhpCXptIeKw7
 mguEt+DOiRQowzChEGdn6Y4paYOB2nU=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-_PLL2JkxMh-O9yE-nCFTjA-1; Thu, 18 May 2023 13:12:48 -0400
X-MC-Unique: _PLL2JkxMh-O9yE-nCFTjA-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-51b8837479fso2144646a12.3
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 10:12:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684429967; x=1687021967;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l2vyHlKeWqUZbPd7XzbAiQoZNXRMWHkABUYYxs/lXFs=;
 b=ar1CzGkKPTXMNEYCnP1SyllA7KL+KJzRSciYk6R8uCE49sF6dUGuITV1zqT6y32i51
 qiNuogp7wl/lMzSAxvwL3wAGYgdY07NVZ0G29En4+ZyiGNyK6cNip5nFwCfgSipqnufe
 21xIaPrZTbtg963cetWfjMjboMraamTC7BGo26wFaci0MNATX+bkHXA/eL+/34WD9x3c
 rBtBB++7jyVnyhDHYnkx5mkRBZdmJuGb7nDH5kwlNPjf1XtbSg5oN6CJZ19q1hJF6VYD
 hMDWmIQBiYBlqiYs2v/DH2EXGUgo2KYnkxqgbjab+v9iTS3thdiAHsbilIsDO0a4PjDO
 /CNw==
X-Gm-Message-State: AC+VfDwYbxbDP6LRHUtjLCjLqj5Ft2DMPEpzc2aCQbAfm3Fpxlvk8s43
 yxnZHKp/5iIfHNgq0fwSiR6CJfLHcJAgsybXvKRTCKqDloc/lQMjtkpTL7tp/yKmFLFH/OFGsIk
 TfvjLuZFGn6Dbb6g=
X-Received: by 2002:a17:902:904a:b0:1ad:1c29:80ef with SMTP id
 w10-20020a170902904a00b001ad1c2980efmr3349370plz.18.1684429967073; 
 Thu, 18 May 2023 10:12:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ54worK/lSVSVJ1g19qw97+eiQ5oUbt1KgAaTxE+fUFEHSrnaLPMCQaiQ4csM26i7J9Ff291A==
X-Received: by 2002:a17:902:904a:b0:1ad:1c29:80ef with SMTP id
 w10-20020a170902904a00b001ad1c2980efmr3349354plz.18.1684429966791; 
 Thu, 18 May 2023 10:12:46 -0700 (PDT)
Received: from smtpclient.apple ([115.96.106.170])
 by smtp.gmail.com with ESMTPSA id
 u11-20020a170902e80b00b001a6388ce38bsm1672855plg.240.2023.05.18.10.12.43
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 18 May 2023 10:12:46 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH] docs/devel: remind developers to run CI container
 pipeline when updating images
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <871qjdn63l.fsf@linaro.org>
Date: Thu, 18 May 2023 22:42:41 +0530
Cc: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, berrange@redhat.com, qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <348C6573-45A6-4C84-9442-F3288FB6C92E@redhat.com>
References: <20230506072012.10350-1-anisinha@redhat.com>
 <871qjdn63l.fsf@linaro.org>
To: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
X-Mailer: Apple Mail (2.3696.120.41.1.3)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
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



> On 18-May-2023, at 6:34 PM, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>=20
>=20
> Ani Sinha <anisinha@redhat.com> writes:
>=20
>> When new dependencies and packages are added to containers, its =
important to
>> run CI container generation pipelines on gitlab to make sure that =
there are no
>> obvious conflicts between packages that are being added and those =
that are
>> already present. Running CI container pipelines will make sure that =
there are
>> no such breakages before we commit the change updating the =
containers. Add a
>> line in the documentation reminding developers to run the pipeline =
before
>> submitting the change. It will also ease the life of the maintainers.
>>=20
>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>=20
> Queued to testing/next, thanks.

Alex, Thomas already merged this, see 2a851fca9fcf6=20


