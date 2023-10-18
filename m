Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34AA47CD982
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 12:45:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt42S-0007Vs-Au; Wed, 18 Oct 2023 06:44:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qt42O-0007Vi-LK
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 06:44:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qt42N-0005fy-6s
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 06:44:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697625866;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=kZaE+zXmbbuGKHlemSy0dZBUpJqSxECFmFIxAX3yCaw=;
 b=ZZ6i4UZUrVa+VjeR5+CGnGcbNFSOAPeW7NiTzmAMrDD6Kg5m7FwQJKonzDchXxP3C2BCFh
 oN3xvKNVATvXHBkkNroqcM19VeuLiWRNhyqxzeV0RPW/F0rrCXsB0FA6Vrah3xvpSqWGcS
 BpY9L2uOfKXbGb3d6TZ3zZHREDPo+7g=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-MlMOlu2kMc-R1P0_gHkGfg-1; Wed, 18 Oct 2023 06:44:09 -0400
X-MC-Unique: MlMOlu2kMc-R1P0_gHkGfg-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5043353efbdso6285915e87.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 03:44:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697625848; x=1698230648;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kZaE+zXmbbuGKHlemSy0dZBUpJqSxECFmFIxAX3yCaw=;
 b=TmmROUbpXxWDKRuEqaxHyWUkVB7uZpG+JeIWqxgJGdy+gN81JwfDPLilQqjWJTU5eH
 Jw1m2zsOIYvmW23Fm9oJyQC3gS2zM6hvLuzyASNajvBwgZd15xofNN+BLzSDteIx//bs
 wUgMJ7ZalXUGWIgnEx5U/JuF6Du4WmpbyoXb6oKPVASP1dGruZPIqUaNCVYu/w0MLJnO
 xD3cEyo183WxN+I+TYYGEvFPO77/IX2R8I5M6+4tqdKSFv24Ue7vnna+qH2a3Uej89+x
 HrWwYMJn27Yk6TxsULPFuOYG6cBIjvoXxssyH68z++gGRv9VstK/+SuPb8ecnHWq4ECx
 5itA==
X-Gm-Message-State: AOJu0YyKa3wG1z81HO6AxNEy2bY2RIbOExFhvyimEVMOHalP+u8z3MLk
 fAh990KD11FFNO4UbosnyLPpGxJdr5ckwHBXUWQZWLL1xpnqwHmZ1AJkgoHnI3JeKybPJZJmM6o
 3xs9FrTrkCbOumSE=
X-Received: by 2002:ac2:46d6:0:b0:507:9f0a:60e5 with SMTP id
 p22-20020ac246d6000000b005079f0a60e5mr3279470lfo.43.1697625848539; 
 Wed, 18 Oct 2023 03:44:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbNMFPTn7Sh32k5Va2fKFPk7uvCoUVeJT3Koe+BwGppoE9UtVrPwd8v7nFiXSzk4VUm+3eOw==
X-Received: by 2002:ac2:46d6:0:b0:507:9f0a:60e5 with SMTP id
 p22-20020ac246d6000000b005079f0a60e5mr3279462lfo.43.1697625848195; 
 Wed, 18 Oct 2023 03:44:08 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 b14-20020a05600c4e0e00b0040607da271asm1322518wmq.31.2023.10.18.03.44.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 03:44:07 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>
Subject: Re: [PATCH v2 2/3] migration/doc: How to migrate when hosts have
 different features
In-Reply-To: <87mswhw5vn.fsf@suse.de> (Fabiano Rosas's message of "Tue, 17 Oct
 2023 13:50:04 -0300")
References: <20231017151857.21328-1-quintela@redhat.com>
 <20231017151857.21328-3-quintela@redhat.com> <87mswhw5vn.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 18 Oct 2023 12:44:07 +0200
Message-ID: <877cnkxlag.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Fabiano Rosas <farosas@suse.de> wrote:
> Juan Quintela <quintela@redhat.com> writes:
>> +Notice that this is not completely related to QEMU.  The most
>> +important thing here is that this should be handle by the managing
>
> s/handle/handled/

Done.

>> +application that launches QEMU.  If QEMU is configured correctly, the
>> +migration will suceeed.
>
> s/suceeed/succeed/

Done.

>
>> +
>> +Once that we have defined that, doing this is complicated.  Almost all
>
> I get what you mean here, but it is slightly confusing. Maybe
>
> "Once we have defined that, doing it is complicated." or
> "That said, actually doing it is complicated."

Last one wins.

>> +When both hosts have different cpu features this is waranteed to
>> fail.
>
> s/waranteed/guaranteed/

Done.
>> +And you would be able to migrate between them.  It is responsability
>> +of the management application or of the user to make sure that the
>> +configuration is correct.  QEMU don't know how to look at this kind of
>
> s/don't/doesn't/

Done

>> +features in general.
>> +
>> +Notice that we don't recomend to use -cpu host for migration.  It is
>> +used in this example because it makes the exampler simpler.
>
> s/exampler/example/

Thanks.


