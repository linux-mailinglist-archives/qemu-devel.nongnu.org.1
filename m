Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFB67C566E
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 16:11:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqZv9-0002ky-II; Wed, 11 Oct 2023 10:10:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqZun-0002ic-JK
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:10:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqZuh-00083F-H5
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:10:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697033411;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ZZiSDAinDn6LJ8QEbIKl3TdcTQbVJDLtLKnCiS/RmVM=;
 b=Hk/LY8+zsjnG9Doj6cDwn4mDikS0LOvJ/htZMWuZJE5bahuJGpVH+3uwjgrCkZl3HtY2qN
 Gkx/Ae6hUobwm9Ty+iWjWyNVHn8wbO7+aUyvbSqmgj5HOb/Q62QIkIp1LKDc49NQcDHGVH
 y19AAzQikRFHUp9tl83rnC9b2bJZhCk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-JLidpfJPNkqyQQsxUwYVeQ-1; Wed, 11 Oct 2023 10:10:07 -0400
X-MC-Unique: JLidpfJPNkqyQQsxUwYVeQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-32d33e3aea5so1131057f8f.0
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 07:10:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697033406; x=1697638206;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZZiSDAinDn6LJ8QEbIKl3TdcTQbVJDLtLKnCiS/RmVM=;
 b=tK/DRPPJHcTUbkm5+LvV1ILkSELlqijSpc85XTokziySBr9WeIvvl6xYo3hBiY4XWA
 B9wYauxgyirJZNXOm2gKVqh5JO56XH+gbLX031+qMlekaF2uHHIH15x6FEnJVLQXn60d
 s3JCzh3jaexF9OyUcjA44LT1t/IzXR0cHPcUA7oIv8qkfiohKSTwj6o7sCp7cNdULGoB
 n6eD9Tmt3/oLyaAKbCLmlPrOOlStkpXAggs6rIXm60HSEsJ6zU9llC4LOZfsZC0i3iMa
 +1kqRNoqmieuyVHGDcbKs7JygYByFwL6NBdGuNrOZ3j1UzzRje/vyJ5IN/O16Khfoy0I
 7wuw==
X-Gm-Message-State: AOJu0YwJIQQfsjyB0kupsBwpmE9HYSrz5gUyQiL9ZIOloYIZEG73uaXu
 Ufiw7Yz0NyVjx6Dvz+RV4i8Gxmc7P99Rz1i1+RZyHkDfmPQTZs1PigfUGbWJDY7Om+h7Ar4eVri
 e5QrYLX/QydFZ4zguqTsXuHrOsQ==
X-Received: by 2002:adf:e607:0:b0:31f:b9ea:76c with SMTP id
 p7-20020adfe607000000b0031fb9ea076cmr17572021wrm.48.1697033406095; 
 Wed, 11 Oct 2023 07:10:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6IkB2JzAcW3yKtBQvjsaGZ/pCOkxO6oGUrrYFiZW75PkmoTbBaHdKtgi0bCZnqWzG15jO2g==
X-Received: by 2002:adf:e607:0:b0:31f:b9ea:76c with SMTP id
 p7-20020adfe607000000b0031fb9ea076cmr17571999wrm.48.1697033405715; 
 Wed, 11 Oct 2023 07:10:05 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 s4-20020a5d6a84000000b00327bf4f2f14sm15610428wru.88.2023.10.11.07.10.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 07:10:05 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,  John Snow <jsnow@redhat.com>,  Cleber
 Rosa <crosa@redhat.com>
Subject: Re: [PATCH v2 4/6] migration: Fix analyze-migration.py when
 ignore-shared is used
In-Reply-To: <87sf6h1dyy.fsf@suse.de> (Fabiano Rosas's message of "Wed, 11 Oct
 2023 10:32:53 -0300")
References: <20231009184326.15777-1-farosas@suse.de>
 <20231009184326.15777-5-farosas@suse.de>
 <87v8bd9tsr.fsf@secure.mitica> <87sf6h1dyy.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 11 Oct 2023 16:10:04 +0200
Message-ID: <87il7d9rnn.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
>
>> Fabiano Rosas <farosas@suse.de> wrote:
>>> The script is currently broken when the x-ignore-shared capability is
>>> used:
>>>
>>> Traceback (most recent call last):
>>>   File "./scripts/analyze-migration.py", line 656, in <module>
>>>     dump.read(dump_memory = args.memory)
>>>   File "./scripts/analyze-migration.py", line 593, in read
>>>     section.read()
>>>   File "./scripts/analyze-migration.py", line 163, in read
>>>     self.name = self.file.readstr(len = namelen)
>>>   File "./scripts/analyze-migration.py", line 53, in readstr
>>>     return self.readvar(len).decode('utf-8')
>>> UnicodeDecodeError: 'utf-8' codec can't decode byte 0x82 in position 55: invalid start byte
>>>
>>> We're currently adding data to the middle of the ram section depending
>>> on the presence of the capability. As a consequence, any code loading
>>> the ram section needs to know about capabilities so it can interpret
>>> the stream.
>>>
>>> Skip the byte that's added when x-ignore-shared is used to fix the
>>> script.
>>>
>>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>>
>> Reviewed-by: Juan Quintela <quintela@redhat.com>
>>
>>> @@ -582,6 +586,7 @@ def read(self, desc_only = False, dump_memory = False, write_memory = False):
>>>                  config_desc = self.vmsd_desc.get('configuration')
>>>                  section = ConfigurationSection(file, config_desc)
>>>                  section.read()
>>> +                ramargs['ignore_shared'] = section.has_capability('x-ignore-shared')
>>
>> should we consider s/x-ignore-shared/ignore-shared/?
>>
>
> We can consider s/ignore-shared/x-ignore-shared/ if that's what you
> mean. The way you suggested doesn't work because the cap name comes from
> QEMU with the "x-" part in it.
>
> If you meant filtering the x out when parsing the capabilities in this
> script, I think that would cause a sort of a UX issue because we need to
> use x-ignore-shared to set the cap in QMP/HMP.

No.

I mean if we should start supporting ignore-shared.

Later, Juan.


