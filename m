Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EAE5719B95
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 14:11:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4h8S-00021z-6b; Thu, 01 Jun 2023 08:10:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q4h8B-00020f-K6
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 08:10:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q4h89-0005aT-AI
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 08:10:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685621412;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KOLEbgCxiLK7uTpbn1UVEULHSEnmZ3XR8zF7xu0AuaU=;
 b=VrVGIftFIWkzadhJP/pIWTfqorsSrczdVxEaKbW5GiQzvj347sGp0syt20FCc5q+lGfmJK
 1ER11CLEJFGg5tZ6OFpRlyHorgPLURJB3rylQIY6svMnDQkjQbBJPvolf/21ybM7xi6X2E
 dUQYcKgzXJIaa6KszQc1qzFZnPyqx/U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-UCfV4geiMEa4Zf_3TkXBBw-1; Thu, 01 Jun 2023 08:10:10 -0400
X-MC-Unique: UCfV4geiMEa4Zf_3TkXBBw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-30a5d4e5731so402492f8f.1
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 05:10:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685621408; x=1688213408;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KOLEbgCxiLK7uTpbn1UVEULHSEnmZ3XR8zF7xu0AuaU=;
 b=L7TnH5QRlqpDdYVqkJZ4UyxPzKSBPvdhghZVFoZaabmIAAklyBsufPH9y1tUoENJFo
 qJeImt9tcVZL8Vd1ugc95VNVIIM1/LyY6wx/TbjFgzUD0oSGwK7LmONqSN2PHqZc81TS
 dkxy/j3AvEFbWXiUs6f8jAPw7TZnt/Y/f0LD43+fiMMjVNAgXAeQH+zKLRc7OoFCzBlV
 n9yMItb0/4rFR8hEUD21ZUsJsU37yJCbdhuRj7haHeNN9j1fL1Plc5hs7ri+OpwKoMW4
 84iNqzEwqmhbja+L8WCs7IuMExlY2BKJwEETNqeTnF6uJeLITcwwhYMTwOJicxVHqAI8
 gfiA==
X-Gm-Message-State: AC+VfDzUO/OkXYS+P/4uAsWXlhP9USC9d+PDZH6dyTTpligUkTiAs9R0
 +7RHfMqWnxhoBATBAxUlDqdkAppWZ6h+sasqIxBr6L+1aDjk77p4aQSpg9tec3s0szjcstaNirU
 +1DvT+D+ykztd+DPBGMV5x//Wow==
X-Received: by 2002:adf:fa4f:0:b0:30a:eb3f:509f with SMTP id
 y15-20020adffa4f000000b0030aeb3f509fmr1677889wrr.60.1685621408666; 
 Thu, 01 Jun 2023 05:10:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4Sg6ebHtwrF+xo4qwBQDo/MXc5iaC740JfALJ0F/a93Itu9G2zRDhCHqRq+qDDeAurS1nR2w==
X-Received: by 2002:adf:fa4f:0:b0:30a:eb3f:509f with SMTP id
 y15-20020adffa4f000000b0030aeb3f509fmr1677868wrr.60.1685621408407; 
 Thu, 01 Jun 2023 05:10:08 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 u5-20020adff885000000b0030ae16132besm10214595wrp.12.2023.06.01.05.10.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 05:10:07 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Laurent Vivier <lvivier@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  Leonardo Bras <leobras@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 4/9] tests/qtest: get rid of some 'qtest_qmp' usage
 in migration test
In-Reply-To: <20230531132400.1129576-5-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Wed, 31 May 2023 14:23:55
 +0100")
References: <20230531132400.1129576-1-berrange@redhat.com>
 <20230531132400.1129576-5-berrange@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Thu, 01 Jun 2023 14:10:06 +0200
Message-ID: <875y87tmch.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> Some of the usage is just a verbose way of re-inventing the
> qtest_qmp_assert_success(_ref) methods.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


