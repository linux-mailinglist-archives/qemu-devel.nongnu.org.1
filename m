Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B35707EFC
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 13:14:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzbZg-0005xU-Ib; Thu, 18 May 2023 07:13:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pzbZe-0005xH-7r
 for qemu-devel@nongnu.org; Thu, 18 May 2023 07:13:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pzbZc-0006qp-S1
 for qemu-devel@nongnu.org; Thu, 18 May 2023 07:13:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684408411;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=TsqX528aJIiJocOZgpuIpkKJFO3nXMjCEGEsYXkoo8I=;
 b=c5GSHS5NswKqaimuhuYNmAsIo6ymIiC5pcCNdvDvVSQSYVSexsTWjEN0Iph5DyfaBrEMbR
 SqrWwLyTc0+e2R0Gycmc0chYaU44/ZMSZ4q7XCiuVz4TqDILZH+/yBVJ2TClcCyF4twqGL
 jWi4JLmimu4gxVHHKKVnCqiG1DwLj5M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85--PDC-q24MbqJw6E0QI1-tw-1; Thu, 18 May 2023 07:13:30 -0400
X-MC-Unique: -PDC-q24MbqJw6E0QI1-tw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f420ec766dso12753975e9.1
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 04:13:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684408409; x=1687000409;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TsqX528aJIiJocOZgpuIpkKJFO3nXMjCEGEsYXkoo8I=;
 b=kYYasYjTIiWSpbIsSxQI6CNcqPUbYC8eWNZ7VdQa+VRRvRhEpdopLhhx5RsRwnM394
 j99GNZPwCUgVW4sWqK2raSfqNqna/7GjlejIZh00AIgr7mnArdz6vqnJZodN/n5OEsri
 WHufEzeg0LkWt8Yj7Es5EcBSnqpvAdNFBA7Gc2KQlPgL8DuH0p2QLZN+nrJiqoGfDK7v
 Eg2sqZc2GAGHpRjpxRXPAhqQM/0npX4ONwBpOpFysk2ge4i6+W+YOWuX0Dcd0G8biZhR
 r7JARRwxFveSlicMSaTEgBaqGU8cg8dTV82ERjDtb+QPyYNWf6+Bd5pioDlZ48qjbNaf
 gcYQ==
X-Gm-Message-State: AC+VfDy9A+Lnc9NSc1Ah6ZTKfei1TdW2wFkLud3CxeowN+Hv6N/KojS8
 8IKV+t6ThwTAAhxKM3yYwEO8ywGCtyLzP9G4YhsQ7/96sIddgE8X+gaYbhAIhqkmnJrcQ0oZAb5
 7bNY+AOGzrdGYrJUJg0Odsuvmhw==
X-Received: by 2002:a1c:c90f:0:b0:3f4:20bd:ba46 with SMTP id
 f15-20020a1cc90f000000b003f420bdba46mr1175756wmb.5.1684408409198; 
 Thu, 18 May 2023 04:13:29 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ51891/wE6oylILwW94GVEpqOk0VVcKiZ/yrYNZ0kqNLUkkLSRLuxu40NqSoARdx4nX/Wyglw==
X-Received: by 2002:a1c:c90f:0:b0:3f4:20bd:ba46 with SMTP id
 f15-20020a1cc90f000000b003f420bdba46mr1175745wmb.5.1684408408898; 
 Thu, 18 May 2023 04:13:28 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 n6-20020a05600c294600b003f50876905dsm1739174wmd.6.2023.05.18.04.13.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 04:13:28 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org,  pbonzini@redhat.com,  leobras@redhat.com,
 peterx@redhat.com,  yc-core@yandex-team.ru
Subject: Re: [PATCH 1/5] runstate: add runstate_get()
In-Reply-To: <20230517123752.21615-2-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Wed, 17 May 2023 15:37:48 +0300")
References: <20230517123752.21615-1-vsementsov@yandex-team.ru>
 <20230517123752.21615-2-vsementsov@yandex-team.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Thu, 18 May 2023 13:13:27 +0200
Message-ID: <87mt21evu0.fsf@secure.mitica>
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> wrote:
> It's necessary to restore the state after failed/cancelled migration in
> further commit.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Reviewed-by: Juan Quintela <quintela@redhat.com>


