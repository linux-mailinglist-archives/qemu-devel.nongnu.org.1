Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 434787164C7
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 16:48:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q40e6-0000Vq-QM; Tue, 30 May 2023 10:48:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q40do-0000QI-KU
 for qemu-devel@nongnu.org; Tue, 30 May 2023 10:48:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q40dl-0007YS-Hv
 for qemu-devel@nongnu.org; Tue, 30 May 2023 10:48:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685458079;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G+nENtkWx6L0Xb/u+jboX8eYAT1mJ0UNx8oYvuMtglo=;
 b=GinKWCBsJQdLxWzWoRKWeiqHikq8QpaZPFGoDPnzj+hZDeJKRGxPMZFvOqpcRJSgxj/xrM
 hG/jQ0G7mqP0NvKVEZyLTo1ALsXRd05Lg//0inS2nhdUnrJOWN4ca4Tby66A1ZLvLhTfVb
 /Dxzl7wgyBWpk4btwvvqjkJKvt8sp4I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-NbkgfyVIPYW-VCgjBIaKZA-1; Tue, 30 May 2023 10:47:57 -0400
X-MC-Unique: NbkgfyVIPYW-VCgjBIaKZA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f603b8eb61so26961315e9.0
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 07:47:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685458075; x=1688050075;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G+nENtkWx6L0Xb/u+jboX8eYAT1mJ0UNx8oYvuMtglo=;
 b=NbHvvKuvG2rtB9r2ymXwZ1U2gNLqDs/Gjp6Im429Jpq+FwPF/ZkIjQjp+POIwJYcBL
 rCpyz+n/pUjL9+zbgFiZAM6/TcqGvxSHi+h9P2reS92w7nMQYoPtp6kpflaUo/iOzvXg
 pXb+5kFqCG1okKho3bbdowRlN8GIHYiW4d6fN5iD2DmaigXqcEs4CpmrpmkmhDhbpBF8
 1bkTCLlEdYoJXHyNDFBdqcpPDwM14JBEJed8bMMyONZQrCw1YHde+5JcfMSdldm8V5xQ
 pU2bF9cEpAasRtRlkg03AuVvpYbHvbIz7yrNRxRbJtkMpm8LG2kgqsGUj5TVhw6Orr0D
 VtYQ==
X-Gm-Message-State: AC+VfDwZtHZD9vLgdxZRNHVA64T6JapxhcyoECoO6ePUELbFDUkdupza
 bijYUAXSHccOF3+Odix19Oqaunsl17ffInc3MpjNNNYv32nsVyzPQtOlv+PrST8TBmsyficuZMJ
 Uha/SgXlob2y8cF7RXS0cZV+Mbg==
X-Received: by 2002:a1c:4b12:0:b0:3f6:e42:8f9b with SMTP id
 y18-20020a1c4b12000000b003f60e428f9bmr2228358wma.27.1685458074905; 
 Tue, 30 May 2023 07:47:54 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Pw6B8MtIJ2WSR4S4XHTWjWWduqn8iqXFDhWJ08RiyVp3v10GLrpyzQwZAYCK8dO586peTEg==
X-Received: by 2002:a1c:4b12:0:b0:3f6:e42:8f9b with SMTP id
 y18-20020a1c4b12000000b003f60e428f9bmr2228343wma.27.1685458074633; 
 Tue, 30 May 2023 07:47:54 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 j18-20020a5d4492000000b002ffbf2213d4sm3534726wrq.75.2023.05.30.07.47.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 07:47:54 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  Leonardo Bras <leobras@redhat.com>
Subject: Re: [PULL 00/21] Migration 20230530 patches
In-Reply-To: <a0fa954e-9903-841d-9c00-c035a6ddc8db@linaro.org> (Richard
 Henderson's message of "Tue, 30 May 2023 06:23:37 -0700")
References: <20230530115429.1998-1-quintela@redhat.com>
 <a0fa954e-9903-841d-9c00-c035a6ddc8db@linaro.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Tue, 30 May 2023 16:47:53 +0200
Message-ID: <87bki1x4di.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Richard Henderson <richard.henderson@linaro.org> wrote:
> On 5/30/23 04:54, Juan Quintela wrote:
>> The following changes since commit aa9bbd865502ed517624ab6fe7d4b5d89ca95=
e43:
>>    Merge tag 'pull-ppc-20230528' ofhttps://gitlab.com/danielhb/qemu
>> into staging (2023-05-29 14:31:52 -0700)
>> are available in the Git repository at:
>>    https://gitlab.com/juan.quintela/qemu.git
>> tags/migration-20230530-pull-request
>> for you to fetch changes up to
>> d83da4626ebc1462e8f0065d446f97aece681d90:
>>    migration/rdma: Check sooner if we are in postcopy for
>> save_page() (2023-05-30 13:27:54 +0200)
>> ----------------------------------------------------------------
>> Migration 20230530 Pull request
>> Hi
>> On this PULL request:
>> - Set vmstate migration failure right (vladimir)
>> - Migration QEMUFileHook removal (juan)
>> - Migration Atomic counters (juan)
>> Please apply.
>
> Fails immediately:

And here I am, not checking !CONFIG_RDMA

Sorry.

> In file included from ../src/migration/ram.c:61:
> ../src/migration/rdma.h:52:5: error: no previous prototype for
> =E2=80=98rdma_registration_handle=E2=80=99 [-Werror=3Dmissing-prototypes]
>    52 | int rdma_registration_handle(QEMUFile *f) { return 0; }
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~
> ../src/migration/rdma.h:53:5: error: no previous prototype for
> =E2=80=98rdma_registration_start=E2=80=99 [-Werror=3Dmissing-prototypes]
>    53 | int rdma_registration_start(QEMUFile *f, uint64_t flags) { return=
 0; }
>       |     ^~~~~~~~~~~~~~~~~~~~~~~
> ../src/migration/rdma.h:54:5: error: no previous prototype for
> =E2=80=98rdma_registration_stop=E2=80=99 [-Werror=3Dmissing-prototypes]
>    54 | int rdma_registration_stop(QEMUFile *f, uint64_t flags) { return =
0; }
>       |     ^~~~~~~~~~~~~~~~~~~~~~
> ../src/migration/rdma.h:55:5: error: no previous prototype for
> =E2=80=98rdma_block_notification_handle=E2=80=99 [-Werror=3Dmissing-proto=
types]
>    55 | int rdma_block_notification_handle(QEMUFile *f, const char *name)=
 { return 0; }
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../src/migration/rdma.h:56:5: error: no previous prototype for
> =E2=80=98rdma_control_save_page=E2=80=99 [-Werror=3Dmissing-prototypes]
>    56 | int rdma_control_save_page(QEMUFile *f, ram_addr_t block_offset,
>       |     ^~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
>
>
> r~


