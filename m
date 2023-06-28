Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C61740993
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 09:03:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEPBk-0006ox-7z; Wed, 28 Jun 2023 03:02:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qEPBY-0006oh-IX
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 03:01:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qEPBW-0001km-Qf
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 03:01:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687935709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tUctfs6/o4MmSu+cIfRrt1sVfizfRuwB6/EBUv1c7yE=;
 b=hFH94w59oOyKFiwalSVF1NGPMVVThi5KGPDbJNtscylwhECI3d09CYltktsMN6bHWeKuy2
 ViVlqcqKtPRZfRhbZoTx2vHjTKNZUij2xw7Awth7QXLYKQViZbnXIjSTTnNYloeFGvG5+B
 3rlpJZodx1jLpkB4WZcRmk8Vkhgo5Ek=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-wtFjIgojOEiwDpELLgHysg-1; Wed, 28 Jun 2023 03:01:47 -0400
X-MC-Unique: wtFjIgojOEiwDpELLgHysg-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-55768bf3ffdso2402595a12.1
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 00:01:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687935706; x=1690527706;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tUctfs6/o4MmSu+cIfRrt1sVfizfRuwB6/EBUv1c7yE=;
 b=LaXYV4eDd/5bwhc3W6TboRY+3CtasAWMWUiKQ75/CRA/vqOsnV82qAHa2lSmBcWBIf
 POvB2PUD5MFK6EW1Z19KVarJ5z97AjhilkMRew2RzUbmqsW7s/5eI3hjxjINr5LdvjEZ
 z21hxaZZnkAsMogr5h3pPCv7BlFujBXksD6io6DgXl6SXD3MXHGxA7bGd99NW5m7MT3j
 U+BBomrBqChWUTMsTMG/fgsCoTLDbzibxLCb9oEuhoHs3Ut7ib6fv9Z6d/9xBtVxsQ7v
 W9yNDf/kOW5RNjKRYvZBDGpWfVzVX06i9zNKzviGEZeqPP2EgITAX20E9CMX2iORThYD
 UEYw==
X-Gm-Message-State: AC+VfDzOTowABdtAfrlxCDDkNBHZgUDG00OlQQ60rX54pIGLM38A3HMD
 JtsB4kuoAzn3Y9Bo3Xfz8MDmHoQ2TOO/9/JEaHVF/c3CgycLHpOV752uWja4vO7gZ4btVFj5rSF
 397R2V/UC97gKSKQ=
X-Received: by 2002:a05:6a21:9991:b0:12a:c35f:3497 with SMTP id
 ve17-20020a056a21999100b0012ac35f3497mr4184049pzb.32.1687935706258; 
 Wed, 28 Jun 2023 00:01:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5I4CnST4jvFgLxvimXL0cBYWh5v6iZQ1I1I+8nvj8C1BsMEH5xoh2o7qiPkv0sEpK3sf7+BQ==
X-Received: by 2002:a05:6a21:9991:b0:12a:c35f:3497 with SMTP id
 ve17-20020a056a21999100b0012ac35f3497mr4184026pzb.32.1687935705963; 
 Wed, 28 Jun 2023 00:01:45 -0700 (PDT)
Received: from smtpclient.apple ([115.96.122.163])
 by smtp.gmail.com with ESMTPSA id
 i18-20020aa787d2000000b0066e7a540e9csm5893029pfo.140.2023.06.28.00.01.43
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 28 Jun 2023 00:01:45 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: ARI and igb emulation
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <CACGkMEtjPqWYcF_bPoSu9AjrYJFVsXMh+q4ADtdz5HMG64dVcg@mail.gmail.com>
Date: Wed, 28 Jun 2023 12:31:37 +0530
Cc: "Michael S. Tsirkin" <mst@redhat.com>, akihiko.odaki@daynix.com,
 Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E0FEFB1B-2282-4040-92AC-BDB46D65EA07@redhat.com>
References: <ACCE3C63-50B6-4310-9DF6-F1BE759F5B1E@redhat.com>
 <20230627103454-mutt-send-email-mst@kernel.org>
 <25A57CF2-5027-48B7-A879-8DE8BDEF60B3@redhat.com>
 <CACGkMEtjPqWYcF_bPoSu9AjrYJFVsXMh+q4ADtdz5HMG64dVcg@mail.gmail.com>
To: Jason Wang <jasowang@redhat.com>
X-Mailer: Apple Mail (2.3696.120.41.1.3)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



> On 28-Jun-2023, at 12:23 PM, Jason Wang <jasowang@redhat.com> wrote:
>=20
> On Tue, Jun 27, 2023 at 10:41=E2=80=AFPM Ani Sinha =
<anisinha@redhat.com> wrote:
>>=20
>>=20
>>=20
>>> On 27-Jun-2023, at 8:09 PM, Michael S. Tsirkin <mst@redhat.com> =
wrote:
>>>=20
>>> On Tue, Jun 27, 2023 at 08:02:46PM +0530, Ani Sinha wrote:
>>>> Hi :
>>>> I am proposing a patch in QEMU [1] which may or may not break ARI =
but I wanted to give my best shot in making sure I am not breaking =
anything with ARI enabled. I see that your igb emulation code enables =
ARI with its SRIOV emulation. I ran the qtest and avocado tests that are =
mentioned in [2] and they both pass. Is there anything else/any tweaks =
that I should be doing to make sure I am not breaking ARI with igb?
>>>>=20
>>>> Thanks for information,
>>>> Ani
>>>>=20
>>>> 1. =
https://lists.gnu.org/archive/html/qemu-devel/2023-06/msg05478.html
>>>> 2. https://www.qemu.org/docs/master/system/devices/igb.html
>>>>=20
>>>=20
>>> I think that just creates igb. to test ARI you need to add
>>> igbvf devices. Jason maintains it. But really pls go back on-list.
>>=20
>> +Jason
>> +qemu-devel
>>=20
>=20
> Yes, you need to at least create VFS and test some throughput on it
> (probably need a vIOMMU).

Is there a test that I can run?=20


