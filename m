Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6A1737F3B
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 11:58:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBubS-0002P4-L8; Wed, 21 Jun 2023 05:58:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qBubQ-0002Oh-9E
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 05:58:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qBubO-0001Bh-O5
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 05:58:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687341493;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=uWsYA+kLlQK5RjMBQvQ44g07/GzVlb9FKo/XgkvxgiQ=;
 b=bOA9gehinc3vgiqNF2RYCvnHWdS+nEVosaoj3I0+c60S0IfSaQIwLLVaQURo6UILYBotcD
 YJ2FUB2s1mdjFQtrZSks7eqUu4jC+oARLxsTrAUHDUfOSZdYF0IOvEsOjOebXlQmCpNGmC
 qxlNr/KCYaReo7kKH5q70hqY9JOuX6I=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-7K3ND8ZLMtG9qx3DHohKdg-1; Wed, 21 Jun 2023 05:58:12 -0400
X-MC-Unique: 7K3ND8ZLMtG9qx3DHohKdg-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-4f8727c7fb6so2576365e87.0
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 02:58:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687341491; x=1689933491;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uWsYA+kLlQK5RjMBQvQ44g07/GzVlb9FKo/XgkvxgiQ=;
 b=Z3FgLsLGejkWRRGbRAl6StMM7SzR2NJgn6Ef5Ru81IX1XuR/5cKwESPjU+VWW/D0td
 S66OC9GUdi4FL1wNmR+p4FXkAGXwYum6qlcUyiaKhu0p0snFNvWYKbU255KQgCbrv7sn
 Gp1TVMuET+Ds5EBUg8c4Fv3g3nw6/8N2F7KeR/xKUiBGSXXeLwXOnFDod8MUiB+ZYtuy
 D5xi033o97CiA43B83P6OtRcEpsRZ2aMQBt5i80tV0CfPRZRqtw/pz3J5n6fVaDks4pZ
 v4ziloPZ/G3er0pcUg66b3JRKnwxykNBiC9lcYYZbnQpNsiPkFhhmh3cm8hxiB8m/P7h
 w9Fw==
X-Gm-Message-State: AC+VfDyiM5se3Y7eCmVpuvoRzs0tbL/fpjjcMY8sxmX/FoP0yrptfwRK
 R4I86/6XPrMQNH/1l+GdCaztdS69hD9lZduWozciH7lywWtS2iKpEqKgXjkn7kt7a9kQd29d+tX
 inp2r5Z2tYJQrb+Y=
X-Received: by 2002:a19:6750:0:b0:4f8:6cb4:ea37 with SMTP id
 e16-20020a196750000000b004f86cb4ea37mr5244766lfj.16.1687341490913; 
 Wed, 21 Jun 2023 02:58:10 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7SIeWeKEXq48HxXsQnQgSDvgiDEp0ltHklt4vKZOhwt5SNxgezWA5veNVolsbw5vMOjzzqSg==
X-Received: by 2002:a19:6750:0:b0:4f8:6cb4:ea37 with SMTP id
 e16-20020a196750000000b004f86cb4ea37mr5244761lfj.16.1687341490491; 
 Wed, 21 Jun 2023 02:58:10 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 n8-20020a05600c294800b003f90a604885sm4509340wmd.34.2023.06.21.02.58.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jun 2023 02:58:09 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Laurent
 Vivier <lvivier@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH 11/42] migration-test: Update test_ignore_shared to use
 args
In-Reply-To: <ZJHD94Moce7KPqzq@x1n> (Peter Xu's message of "Tue, 20 Jun 2023
 11:21:27 -0400")
References: <20230608224943.3877-1-quintela@redhat.com>
 <20230608224943.3877-12-quintela@redhat.com> <ZJHD94Moce7KPqzq@x1n>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Wed, 21 Jun 2023 11:58:09 +0200
Message-ID: <87legdb0i6.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Peter Xu <peterx@redhat.com> wrote:
> On Fri, Jun 09, 2023 at 12:49:12AM +0200, Juan Quintela wrote:
>> It missed this treatment:
>> 
>> commit 11f1a4ce14803f15d59cff42a4cfb7ac50d36bd0
>> Author: Juan Quintela <quintela@redhat.com>
>> Date:   Mon Nov 29 18:57:51 2021 +0100
>> 
>>     migration-test: Check for shared memory like for everything else
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>
> This is still under "#if 0" block.. and the old code doesn't even compile,
> but the change looks fine.

With the change it compiles O:-)

> Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks. 


