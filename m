Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC90E9C9629
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Nov 2024 00:34:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBjL5-0003w3-6O; Thu, 14 Nov 2024 18:33:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tBjL2-0003vR-HW
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 18:33:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tBjL1-0003Qo-2k
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 18:33:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731627201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5Xdwjgl0ygJYEBm3NvNEnlV5f2GS1eJkyg4n6/dDe9s=;
 b=gKTH94AKckFYRj2Qg3DbOvPzsdB9xx3byuqOhcFPBJkxboVkPiTh5iPndZd3ghnasIuqjL
 TlZ+5DkjEJqEXXTWYSN02ptAYVfQB6759bVpiEfOdL0RstyBge2mMmDilAs0UVCev5ThbJ
 Qf+DGGq1je85mG7/BtIC1K3l4f+thcI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-7WvZhkbjPv-Ibl_LFL03JQ-1; Thu, 14 Nov 2024 18:33:19 -0500
X-MC-Unique: 7WvZhkbjPv-Ibl_LFL03JQ-1
X-Mimecast-MFC-AGG-ID: 7WvZhkbjPv-Ibl_LFL03JQ
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4314f023f55so8005965e9.2
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 15:33:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731627198; x=1732231998;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5Xdwjgl0ygJYEBm3NvNEnlV5f2GS1eJkyg4n6/dDe9s=;
 b=wQfwr4OUoJvDhQVrbAW9qB1LfFd/dFqboCLs4I9/uYqnS9rjoEU/lqyky/2Mrmnipj
 VgeAHujIQJLqVA0pEgYGy74socj066O6NXBecWRryi+lV3MPHyhGNmE0LqlUog2IXIcY
 oQxuYVU32K8lw3Xr2OVt0eitg60AA+YdWskuK2tMp0q9ZJ7PZZOghD8PTMcC/I8oHQtj
 scpKtUECZntfz3C1by+eU19a483PDuFfjHy17HYbUhCitKva92BOCDVtDgpZTSv0Weki
 iZv5yj/p4xlGr+DDChPIf6576Cs3GVjnXWYGaYuWVPTW16fmgrEDUWk+/REiq3o4NoVl
 HRkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0InRdo21cfGYgdNefwsvD1sh2/m7qdNfG4rfrYk/RJ4C7pkLJRTGr4kJRG8vLNm/XNxsJQQ7W4npe@nongnu.org
X-Gm-Message-State: AOJu0Yzu7zOnYY03EE6h5JW8Ug0ZsWWJFUGvgbg/fFppICJb7AO291k1
 moBimLBJwRHre7TgHvOwnGzZS0dZOjeLODwHJbtgG6ycgrO+HAqch22gq86PPWcpY0IUyp4rYv0
 wKYnI9wb+PGfx5J/2bgpKNfQ9zr+GQiRzF+2lgwjCmlJz0eSAlS1J
X-Received: by 2002:a05:600c:1907:b0:430:52ec:1e2b with SMTP id
 5b1f17b1804b1-432df791b70mr3756565e9.29.1731627198690; 
 Thu, 14 Nov 2024 15:33:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGGDMp5ENyFZut1Mt22s64Q7emXNcxMtfZCc+rO6qnvLm/bCyOS3qhIu4QrfLfrsyLSBXmVCQ==
X-Received: by 2002:a05:600c:1907:b0:430:52ec:1e2b with SMTP id
 5b1f17b1804b1-432df791b70mr3756485e9.29.1731627198311; 
 Thu, 14 Nov 2024 15:33:18 -0800 (PST)
Received: from [192.168.10.3] ([151.49.84.243])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-432da265907sm39993895e9.13.2024.11.14.15.33.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 15:33:17 -0800 (PST)
Message-ID: <8f168636-3468-4dc7-9de2-a5958df97c2d@redhat.com>
Date: Fri, 15 Nov 2024 00:33:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: "make clean" after "git pull" runs configure before cleaning.
To: Rob Landley <rob@landley.net>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
References: <86871f60-983e-4172-a6e6-1bd4b1e4e5c0@landley.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <86871f60-983e-4172-a6e6-1bd4b1e4e5c0@landley.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.69,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 11/15/24 00:10, Rob Landley wrote:
> Seems a _bit_ awkward to do that (and potentially fail on a random new 
> dependency) just to delete it all again?

That's just how Make works.  If it finds that Makefile is old, it first 
regenerates Makefile and only then looks at the target.  See "How 
Makefiles Are Remade" in GNU Make's manual: "After reading in all 
makefiles 'make' will consider each as a goal target, in the order in 
which they were processed, and attempt to update it. [...] After all 
makefiles have been checked, if any have actually been changed, 'make' 
starts with a clean slate and reads all the makefiles over again".

> And I dunno what it's saying about the meson version

QEMU bundles a copy of Meson because it needs a very new one.

Paolo


