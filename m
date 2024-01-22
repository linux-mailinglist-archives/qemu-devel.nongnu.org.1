Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B98B837066
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 19:44:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRzHK-0006SZ-L1; Mon, 22 Jan 2024 13:44:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1rRzHH-0006R7-KW; Mon, 22 Jan 2024 13:44:12 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1rRzHG-0006ts-0R; Mon, 22 Jan 2024 13:44:11 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-29080973530so1455568a91.1; 
 Mon, 22 Jan 2024 10:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705949047; x=1706553847; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HV8ttvRIyT0Xeby9+IF6pg8qLS5ZLJ0l5G30GgaYlVs=;
 b=e0DVnEBT19z6HSIxg7/itr66P0VDKa8jaNynBGJdhD5wLocOSImRO559sJ9T6gZSAA
 3Z6NEy0dZ7JY2eSyYMJFXOo8qs/0JjnDA2DD+r10sx//PTLDB/809dZ3EHs1btuaQAOD
 3/y60roBrDuoa/8D68g4bSrjWDpooOI3QHAARQb5rb2/fic5a/OdW7VWbg7P4vaXBC7G
 khrhXba2mS1cS+cUEHaHmOOaRw+jzVTSWUaLqbOGAo9QeQ/3QsjUZYSQ3dAX5/1qGtKA
 WwoD68loy6eIn+C8sS6VwbZ39juDnXBN3/dZWHcN7ycjvq8XLS78ZNu5z7BU26Kc+UtY
 YV2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705949047; x=1706553847;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HV8ttvRIyT0Xeby9+IF6pg8qLS5ZLJ0l5G30GgaYlVs=;
 b=h21F9SqZ1ssgwOd5+v2gbOe9enZ5LinYDt1s8ZuQ12QW/oMtaGa0+ed5jRuNjpnz8e
 rr/LoXTbgRX7Ne94pRyD03H28Rh2kWapuXEMgbA5fcF8fqxIf/0HxWt2njod6jF/WUjG
 N/ErIqeFsRkn6AbUgn6gXjKbx3QivYtK2RoBgV7nWmDies05tRLRMHxALsBstKk0Vxdh
 /ynTvIWxe9ZZZXxBtwotk8C4KXbMmhJrKpEmpF5mpLNEeRyTSOeJTIAwfV4JkQmxI09t
 ENn2mCmYlBVXDMIqDOXsToETy6XNzwC+rvRxu6zzXOzRRapyxgSsytwDaC8rmTAwcVgw
 OBfw==
X-Gm-Message-State: AOJu0Yx29h+/7P2CF4OKagTPJSYbnBe2BziiNcHnwZbMqBJcoKC9b9WW
 ccchVO4dPyFegc5nFgVSCW8g++6Jjyqfm68Ni5kKdDTUqtOY1A2oUta0vEQDDce4C6SHaLpW+4r
 4YfHRVHaD4uXKsR4AQrTK/E8kPmw=
X-Google-Smtp-Source: AGHT+IFCCHGy+/YV5FT4k/cailhryvy0cpjC3XBKqbp2XLCknOrQsj3Cn18m4pCucjZjokbQUoFQST4jd3gBa0+gyC4=
X-Received: by 2002:a17:90a:6b84:b0:28e:87a0:c05b with SMTP id
 w4-20020a17090a6b8400b0028e87a0c05bmr2039612pjj.40.1705949047305; Mon, 22 Jan
 2024 10:44:07 -0800 (PST)
MIME-Version: 1.0
References: <20231127085641.3729-1-faithilikerun@gmail.com>
 <ZZ4-lo64mGubad5t@cormorant.local>
In-Reply-To: <ZZ4-lo64mGubad5t@cormorant.local>
From: Sam Li <faithilikerun@gmail.com>
Date: Mon, 22 Jan 2024 19:43:41 +0100
Message-ID: <CAAAx-8Ko+0M85AXMad8UCsLspYjBXm7nqOs_yZkKOKqsDy-PgA@mail.gmail.com>
Subject: Re: [RFC v2 0/7] Add persistence to NVMe ZNS emulation
To: Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, qemu-block@nongnu.org, 
 hare@suse.de, David Hildenbrand <david@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Keith Busch <kbusch@kernel.org>, Hanna Reitz <hreitz@redhat.com>,
 dmitry.fomichev@wdc.com, 
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eric Blake <eblake@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 dlemoal@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=faithilikerun@gmail.com; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Klaus Jensen <its@irrelevant.dk> =E4=BA=8E2024=E5=B9=B41=E6=9C=8810=E6=97=
=A5=E5=91=A8=E4=B8=89 07:52=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Sam,
>
> This is awesome. For the hw/nvme parts,
>
> Acked-by: Klaus Jensen <k.jensen@samsung.com>
>
> I'll give it a proper R-b when you drop the RFC status.

Hi Klaus,

Sorry for the late response. I will submit a new RFC patch series very
soon.

Now the zone states should persist. The following is the result of
regression tests on zonefs. It's been a while since I worked on this
series. Please let me know if I made any mistake.

Thanks,
Sam

[root@guest tests]# ./zonefs-tests.sh /dev/nvme0n1
Gathering information on /dev/nvme0n1...
zonefs-tests on /dev/nvme0n1:
  12 zones (0 conventional zones, 12 sequential zones)
  131072 512B sectors zone size (64 MiB)
  6 max open zones
  8 max active zones
Running tests
...
75 / 112 tests passed (37 skipped, 0 failures)

