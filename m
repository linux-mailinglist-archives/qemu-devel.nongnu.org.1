Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7C3703544
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 18:57:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pybVF-0001Ol-UH; Mon, 15 May 2023 12:56:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pybVD-0001OU-OT
 for qemu-devel@nongnu.org; Mon, 15 May 2023 12:56:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pybVC-0004rX-C4
 for qemu-devel@nongnu.org; Mon, 15 May 2023 12:56:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684169809;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6DA1cA7MzqON9UKmgOtPT1ydqby90k4OUnHSE7uFHys=;
 b=KUroTB6ZIZAHW71qbMCyCgefN7ShXTDWnyYTV7272vGqGzdWCwQXhNhvGVjRWqyyvXoaC/
 O27YvT2pnvHxt8fAabBdBTOd9IIk9ejKN8m1yToy1ieqGxC0n9uW6TCxi5OcGg+1zCxkjG
 a05Z16etGDwDCQrAlFNB/TdfdDZEP8I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-bRawzEo2OiO2Y_xQ8cT1Kg-1; Mon, 15 May 2023 12:56:42 -0400
X-MC-Unique: bRawzEo2OiO2Y_xQ8cT1Kg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-306281812d6so5108179f8f.2
 for <qemu-devel@nongnu.org>; Mon, 15 May 2023 09:56:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684169801; x=1686761801;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6DA1cA7MzqON9UKmgOtPT1ydqby90k4OUnHSE7uFHys=;
 b=JHbUyXpkAUzG9LebSVnpgPjNUFTN/ZRtkVDrgI26x8wVEul1xph1n5yUlrSO+e25dC
 iPgge34UK5q3fOuEQclmTwErvLK16ZnXAuM8cQRnue5Y/9A78bAhc8xSjsu5VzZtBQvI
 yTEPD7Mz4kMuBnhPGGkG1BPAeCaHSKLsZujbYOKWA7316l9ARfZLEAp9fO5y+1Jicv2W
 CuRjQnRx+0eP7MHbLwvurGww8zuyizGd3+B0H/sDc6lSQxZt5T8FvIUOWamCZqgqny+x
 3K+JNInBM09xN/ahk59gYg/dGLg4qYiKkns6MnEDsFvo6sguJzUi0j/9An+pJQWWVLH4
 lj+g==
X-Gm-Message-State: AC+VfDxXfiHZMPCyCNbQ06eiiE90PT3GGMoO/F1433jMJ/FpO2qX4Nku
 CiTWVoTG/04L71u2NT0G1b7dP+szSrf2ErgHOktyWXuEgV4iQxU0d8YYo8keHLVbvG5lHSPB0Ki
 qVL6tJGsazr2acxk=
X-Received: by 2002:adf:ee0c:0:b0:306:2c16:8359 with SMTP id
 y12-20020adfee0c000000b003062c168359mr25724198wrn.39.1684169801664; 
 Mon, 15 May 2023 09:56:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ56Ga5vzEp/eARKodz0T7y/FKzjzijkLlpZYH+lR8jmfkZYVWoHGWG8dCF1/TVW5lgh5ZJhtw==
X-Received: by 2002:adf:ee0c:0:b0:306:2c16:8359 with SMTP id
 y12-20020adfee0c000000b003062c168359mr25724162wrn.39.1684169801317; 
 Mon, 15 May 2023 09:56:41 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 l19-20020a1c7913000000b003f42ceb3bf4sm18954984wme.32.2023.05.15.09.56.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 May 2023 09:56:40 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Warner Losh <imp@bsdimp.com>
Cc: qemu-devel@nongnu.org,  Kyle Evans <kevans@freebsd.org>,  Laurent Vivier
 <laurent@vivier.eu>,  Christian Borntraeger <borntraeger@linux.ibm.com>,
 Daniel P . =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Markus Armbruster <armbru@redhat.com>,
 qemu-s390x@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>
Subject: Re: [RFC 1/3] ARM: Use normal types
In-Reply-To: <CANCZdfpuobM1+v7XWrk1eMBpYKWaRiu_OxOQ2fZwSVnOVSFvRw@mail.gmail.com>
 (Warner Losh's message of "Mon, 15 May 2023 10:46:22 -0600")
References: <20230510143925.4094-1-quintela@redhat.com>
 <20230510143925.4094-2-quintela@redhat.com>
 <CANCZdfp0p6+o5E2CpqC+6BWdzeW4u2019UfHf+RmfQyV-O2mvw@mail.gmail.com>
 <CANCZdfpuobM1+v7XWrk1eMBpYKWaRiu_OxOQ2fZwSVnOVSFvRw@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Mon, 15 May 2023 18:56:39 +0200
Message-ID: <87h6sdy1mg.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Warner Losh <imp@bsdimp.com> wrote:
> On Mon, May 15, 2023 at 10:44=E2=80=AFAM Warner Losh <imp@bsdimp.com> wro=
te:
>
>>
>>
>> On Wed, May 10, 2023 at 8:39=E2=80=AFAM Juan Quintela <quintela@redhat.c=
om> wrote:
>>
>>> Someone has a good reason why this is not a good idea?
>>>
>>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>>>
>>
>> Reviewed by:  Warner Losh <imp@bsdimp.com>
>>
>> This has been that way the bsd-user sources were reorganized in 2015. I
>> can find
>> no good reason in the FreeBSD sources to do this (we've been transitioni=
ng
>> from
>> the pre-standardized BSD convention of u_intXX_t -> uintXX_t for 25 years
>> now
>> it seems). I don't see any old or ancient usage as far back as I looked
>> why they'd
>> be different. Up through FreeBSD 12.x, this was u_int32_t (for all of
>> them), but
>> they switched to __uint32_t in FreeBSD 13 to avoid namespace pollution.
>>
>> tl;dr: change good, all should match.
>>
>
> Though a better commit message would be good. With that, I'll queue it to
> my branch.

I think your bit of history would be good O:-)

Later, Juan.


