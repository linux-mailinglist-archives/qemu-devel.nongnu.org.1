Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D17EA70D23F
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 05:15:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1IT6-0005Xh-3e; Mon, 22 May 2023 23:13:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1q1IT1-0005XS-C6
 for qemu-devel@nongnu.org; Mon, 22 May 2023 23:13:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1q1ISz-000216-L7
 for qemu-devel@nongnu.org; Mon, 22 May 2023 23:13:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684811607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zh2V7uIpRFcHvv81Pvk4kLguGxenn2MDWKGytJUT4Iw=;
 b=bx3XR6JouTY0pyg/ynER/Ky2SEFWubtLYORXOTcANV59MPM2dmEFbW4npwWU+ZPYuAx0g0
 N7AGqbcb0A1bS3jH9WFXOax56Womk62v2r+h+wRlo+S43b3zAPsJBly9yz2FpsezkWH0De
 Z5hZmIy1NrpyZSSRXR6QZatHuQRhMrs=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-uicvvPBuM_-Tl57RxCENgA-1; Mon, 22 May 2023 23:13:25 -0400
X-MC-Unique: uicvvPBuM_-Tl57RxCENgA-1
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-1ae438721e2so37743585ad.2
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 20:13:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684811604; x=1687403604;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zh2V7uIpRFcHvv81Pvk4kLguGxenn2MDWKGytJUT4Iw=;
 b=ckVduqsXz+I7YTYU+xTtKLbtf4wkRp31OkhN2Ac8ERLwgYpmLK5rPI2NL/s1gZLNpX
 LHVIpceRSqEPevsxvjlZ3nVQuF/sn7vZkegJToXd7kWCysb5OzulMSWJpxEBCioNu9XL
 3SKLZQvR+BKK1J4GixGvjacwwgn5uQw+MTpeTsbwneFJTOcAnVsfY8EUgixaRI7/wybx
 O86TXGGCktWihHEV5TpozgnqRVJfdd0NJg0acSv7TLcJ6WIymG8iXTKXXdotYR7g8hLa
 pRmLLuwPHjBglCcoKsBZWLisYuxG+bqLapqLMGnZTXzg4xXCpeYDgjuQFW7ObaV70nol
 OMvw==
X-Gm-Message-State: AC+VfDwv+AC2LsyYlXaL5UD5FTWQE4Uvk7Xn6dSFaPJaRyREzmd35Wta
 mw1gB8ZhUeeUGWWYftJ9NZHI3lcgFo003ehhSLMXj/PgLQsAvEFrpFoEi7/SIAyt0DLpynuEGTX
 cwLE4oqVYrAGKPC0=
X-Received: by 2002:a17:902:e848:b0:1ad:d500:19d3 with SMTP id
 t8-20020a170902e84800b001add50019d3mr16831507plg.23.1684811604461; 
 Mon, 22 May 2023 20:13:24 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5rFNrliaHkK7Xgv95rVGI/LC7a/6xq9jGZ/18Q1EITZC7NxUfcg4c+uDzXmKJOS5lBzwaasQ==
X-Received: by 2002:a17:902:e848:b0:1ad:d500:19d3 with SMTP id
 t8-20020a170902e84800b001add50019d3mr16831491plg.23.1684811604149; 
 Mon, 22 May 2023 20:13:24 -0700 (PDT)
Received: from smtpclient.apple ([115.96.116.222])
 by smtp.gmail.com with ESMTPSA id
 i13-20020a170902eb4d00b001adf6b21c77sm5568749pli.107.2023.05.22.20.13.21
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 22 May 2023 20:13:23 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH] acpi/tests/avocado/bits: enable bios bits avocado tests
 on gitlab CI pipeline
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <ddc978a1-8edb-f284-4a45-6d10d1b7733a@redhat.com>
Date: Tue, 23 May 2023 08:43:18 +0530
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <CEFDA661-24A8-4482-86C8-EC51A696C788@redhat.com>
References: <20230517065357.5614-1-anisinha@redhat.com>
 <501EE8C0-D6C2-4FDE-9747-90932F70EB77@redhat.com>
 <20230521015057-mutt-send-email-mst@kernel.org>
 <ddc978a1-8edb-f284-4a45-6d10d1b7733a@redhat.com>
To: Thomas Huth <thuth@redhat.com>
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



> On 22-May-2023, at 11:30 PM, Thomas Huth <thuth@redhat.com> wrote:
>=20
> On 21/05/2023 07.51, Michael S. Tsirkin wrote:
>> On Fri, May 19, 2023 at 08:44:18PM +0530, Ani Sinha wrote:
>>>=20
>>>=20
>>>> On 17-May-2023, at 12:23 PM, Ani Sinha <anisinha@redhat.com> wrote:
>>>>=20
>>>> Biosbits avocado tests on gitlab has thus far been disabled because =
some
>>>> packages needed by this test was missing in the container images =
used by gitlab
>>>> CI. These packages have now been added with the commit:
>>>>=20
>>>> da9000784c90d ("tests/lcitool: Add mtools and xorriso and remove =
genisoimage as dependencies")
>>>>=20
>>>> Therefore, this change enables bits avocado test on gitlab.
>>>> At the same time, the bits cleanup code has also been made more =
robust with
>>>> this change.
>>>>=20
>>>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>>>=20
>>> Michael, did you forget to queue this?
>> Not that I forgot but it takes me time to process new patches.
>> This came after I started testing the pull.
>=20
> FYI, I've picked it up today.

Thanks Thomas! Much appreciated!


