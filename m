Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 855F9712204
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 10:19:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2Sej-0006Eg-8o; Fri, 26 May 2023 04:18:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q2Seg-00069D-C0
 for qemu-devel@nongnu.org; Fri, 26 May 2023 04:18:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q2See-0006Im-1k
 for qemu-devel@nongnu.org; Fri, 26 May 2023 04:18:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685089111;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nlSidLtRKcoz7C5tXgvhhlpTocGAqLi5gdozFOFI4co=;
 b=YF0rgR5O/D3Xrzm7EBquQK56by0fiKwhwPDZvhcjcu9hMHr+jkT4ZsYo/Z3dJKGx6hpqKC
 8L4mnuMyuTOKIWLfeW2S47JPEBx47wDzSoTjK7xtWkSYpGFdX7m1EwFokeDZz9rHmEACiC
 AyPy/6s9ZU01VTn44Jv8RWD7eCW1EJI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-jNtchFtDPIy4r5OgEYR5qw-1; Fri, 26 May 2023 04:18:27 -0400
X-MC-Unique: jNtchFtDPIy4r5OgEYR5qw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-30ab548ba06so306077f8f.1
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 01:18:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685089106; x=1687681106;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nlSidLtRKcoz7C5tXgvhhlpTocGAqLi5gdozFOFI4co=;
 b=D0FZDKZrsjRNtz9dQeqzqt9SuI+hWNJOlkBapjDJA32ANR6fAd+Sbw4tC1IOa0QVpK
 Oi1GYFFmvmK6rF34cnIvWBCNpsRGdjqQdUzFyagrNzlJVTSPayTZ0h6zxmd/7LMjHAKq
 vPIWvrMSnPafHrXZTfjNVffXBUQnUsRV8cHYt5O0zMe0UpaNAh21rqKMYCwrK8sSVFRO
 YoIqzKq5zRA3u613zMv6XpORVH74tCvBHA/DxxYBel6wkggl4LsBE7Jh8UXGxPS93+Nf
 T2WclKPNl1JVqexOe+35eEWeEkd96SYeNm8eDn1hFCUBygul1PVbwkUA48BAIVFBwLgX
 1ZPA==
X-Gm-Message-State: AC+VfDw7GmvN24EMOwgvyIvke7NOr1A9PIS74bYGLZ9tj63k76LTRDrG
 6mIJBooKA2n8NrcmB88u5QdWIS+ZlicklYg1CnEGfyMIPJLrH+YcIUz1yz2C5Bb+BolKnC2Z3MX
 hDiZiMPvqP0zOQCI=
X-Received: by 2002:a5d:640c:0:b0:301:8551:446a with SMTP id
 z12-20020a5d640c000000b003018551446amr1039168wru.2.1685089106298; 
 Fri, 26 May 2023 01:18:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4tIMdI7otWXd9+/VxxQ0yPBRB0MzJ2Np5TkpM2cBx1B11lG19uU4JqvGNIBeuvwRIIKwH/Pw==
X-Received: by 2002:a5d:640c:0:b0:301:8551:446a with SMTP id
 z12-20020a5d640c000000b003018551446amr1039133wru.2.1685089106015; 
 Fri, 26 May 2023 01:18:26 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 v15-20020a5d4a4f000000b00307c0afc030sm4337125wrs.4.2023.05.26.01.18.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 May 2023 01:18:25 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Leonardo =?utf-8?Q?Br=C3=A1s?= <leobras@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Greg Kurz
 <groug@kaod.org>,  qemu-s390x@nongnu.org,  Fam Zheng <fam@euphon.net>,
 Ilya Leoshkevich <iii@linux.ibm.com>,  Halil Pasic <pasic@linux.ibm.com>,
 John Snow <jsnow@redhat.com>,  qemu-ppc@nongnu.org,  Daniel Henrique
 Barboza <danielhb413@gmail.com>,  Harsh Prateek Bora
 <harshpb@linux.ibm.com>,  Christian Borntraeger
 <borntraeger@linux.ibm.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  David Gibson
 <david@gibson.dropbear.id.au>,  David Hildenbrand <david@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,  Eric Farman
 <farman@linux.ibm.com>,  qemu-block@nongnu.org,  =?utf-8?Q?C=C3=A9dric?= Le
 Goater <clg@kaod.org>,  Eric Blake <eblake@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>
Subject: Re: [PATCH v2 09/16] migration: We don't need the field
 rate_limit_used anymore
In-Reply-To: <59d1842c50010122dd5d18bff65d280d0b2d6b47.camel@redhat.com>
 ("Leonardo =?utf-8?Q?Br=C3=A1s=22's?= message of "Thu, 25 May 2023 03:50:55
 -0300")
References: <20230515195709.63843-1-quintela@redhat.com>
 <20230515195709.63843-10-quintela@redhat.com>
 <59d1842c50010122dd5d18bff65d280d0b2d6b47.camel@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Fri, 26 May 2023 10:18:24 +0200
Message-ID: <87sfbj33qn.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Leonardo Br=C3=A1s <leobras@redhat.com> wrote:
> On Mon, 2023-05-15 at 21:57 +0200, Juan Quintela wrote:
>> Since previous commit, we calculate how much data we have send with
>> migration_transferred_bytes() so no need to maintain this counter and
>> remember to always update it.
>>=20
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

> I reviewed this one together with 8/16.
> It makes sense for me to squash them together, but anyway:

Already in tree.

See explanation for the split on previous patch.

The other reason for the split is that this part of the patch is trivial
to review O:-)

Later, Juan.

>
> Reviewed-by: Leonardo Bras <leobras@redhat.com>


