Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6AE97EE2C0
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 15:28:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3dLR-0002QT-Tn; Thu, 16 Nov 2023 09:27:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1r3dLP-0002Pi-4l
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 09:27:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1r3dLN-0005sR-N7
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 09:27:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700144865;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VbNpAlf7TahvLQtqGdDwWUt1flVSQ/lOfjRYQbgGBYo=;
 b=Z9wpz4kIircfezr6VsbH3ALMPZjVSUEQ1PmWyGVXpYpCm+hXLLozWZnQVZw6VamtzUprK/
 bDN0q6yvY/pOsJ2Xxlr/RdjXq/DD1Dt8BaxkkuP0CxPVGmG00wwfBUJDgwloAtl5HXsvuX
 R/t6sKJW2ashUW+kSLsyM0dsDJGBqig=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-DSkHMVx5NqSmo9BUiGtFTw-1; Thu, 16 Nov 2023 09:27:43 -0500
X-MC-Unique: DSkHMVx5NqSmo9BUiGtFTw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4084e4ce543so5100315e9.3
 for <qemu-devel@nongnu.org>; Thu, 16 Nov 2023 06:27:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700144862; x=1700749662;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VbNpAlf7TahvLQtqGdDwWUt1flVSQ/lOfjRYQbgGBYo=;
 b=KSJiY3t8dbvohT6T+kzT+onqHvbW6Ti++t4vAJcgY8G/i7nlF304Z+tKqtHyCoeDC5
 yqTTY4EDP4t2dghO0KFrc/i+91arKSAHSM2S1cuIRqMhi38S7ackb4dbIylQZdijSxV8
 17m6b1YxDhnk0kTVJml40GODnMZqV8jc/ZOg/7sYY+oWvmjyllnrJ04ZcChOKbD4Osi8
 JSEvYvKoZaT+ipmHsuomNvdZLakMxzXPB8oZLkpvdOcgF9h32DUeD22yMKy+rZtjfQK9
 Npfz+mpGlmW0RGHPaPs8+ay6spV3Ut9vB0DOCSsJIIygBBtO0iFRfGfOG3BQ/EhakB0B
 gC4w==
X-Gm-Message-State: AOJu0Yxh2WSxcZKMrte21lrs+8CqE1e6tWjRODP8lHbhbtyvrxaQfKmk
 3ajfrBNoJ7voLGQMFIdtVKwvNv6Np0RdOZW3oovZyKo+vnZrEJIhK6iBkvhoGIfPYMo1wQ0/SMz
 VxM/qmeBSVdvJTnQ=
X-Received: by 2002:a05:600c:4708:b0:409:6edc:6e5c with SMTP id
 v8-20020a05600c470800b004096edc6e5cmr14337445wmo.0.1700144862629; 
 Thu, 16 Nov 2023 06:27:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExIoNwzsud8c8ibhtly/HkKlHbk5ieviVV2vwvFv5UvThRpmRhMDjcSHT0VvXkwd0EqwVsdg==
X-Received: by 2002:a05:600c:4708:b0:409:6edc:6e5c with SMTP id
 v8-20020a05600c470800b004096edc6e5cmr14337427wmo.0.1700144862246; 
 Thu, 16 Nov 2023 06:27:42 -0800 (PST)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 u5-20020a05600c138500b003fee6e170f9sm3872406wmf.45.2023.11.16.06.27.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Nov 2023 06:27:41 -0800 (PST)
From: Juan Quintela <quintela@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Thomas Huth <thuth@redhat.com>,  qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
Subject: Re: [PATCH trivial 06/21] docs/devel/migration.rst: spelling fix:
 doen't
In-Reply-To: <7259b384-cc7f-4400-9891-83e656765ce2@tls.msk.ru> (Michael
 Tokarev's message of "Wed, 15 Nov 2023 09:41:45 +0300")
References: <20231114165834.2949011-1-mjt@tls.msk.ru>
 <20231114165834.2949011-7-mjt@tls.msk.ru>
 <f2bfef4a-3a2c-4d32-adf6-52317f85a045@redhat.com>
 <7259b384-cc7f-4400-9891-83e656765ce2@tls.msk.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Thu, 16 Nov 2023 15:27:41 +0100
Message-ID: <87a5rdrcwy.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.117,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Michael Tokarev <mjt@tls.msk.ru> wrote:
> 14.11.2023 22:05, Thomas Huth wrote:
>> On 14/11/2023 17.58, Michael Tokarev wrote:
>>> Fixes: 1aefe2ca1423 "migration/doc: Add documentation for backwards com=
patiblity"
>>> Cc: Juan Quintela <quintela@redhat.com>
>>> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
>>> ---
>>> =C2=A0 docs/devel/migration.rst | 8 ++++----
>>> =C2=A0 1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/docs/devel/migration.rst b/docs/devel/migration.rst
>>> index 5adf4f12f7..51b1f61f5e 100644
>>> --- a/docs/devel/migration.rst
>>> +++ b/docs/devel/migration.rst
>>> @@ -1061,7 +1061,7 @@ QEMU version, in this case pc-5.1.
>>> =C2=A0 4 - qemu-5.1 -M pc-5.2=C2=A0 -> migrates to -> qemu-5.1 -M pc-5.2
>>> -=C2=A0 This combination is not possible as the qemu-5.1 doen't underst=
and
>>> +=C2=A0 This combination is not possible as the qemu-5.1 does't underst=
and
>> You replaced one typo with another one :-)
>
> Heh. Lovely! :)
>
> The "really-really-fixed" one (without resending):
>
> -  This combination is not possible as the qemu-5.1 doen't understand
> +  This combination is not possible as the qemu-5.1 doesn't understand
>    pc-5.2 machine type.  So nothing to worry here.
>
> ;)
>
> Thank you for the review and for spotting it!
>
> /mjt

Reviewed-by: Juan Quintela <quintela@redhat.com>
with the change.


