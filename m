Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33CDFB3CBB6
	for <lists+qemu-devel@lfdr.de>; Sat, 30 Aug 2025 17:11:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNBs-0007GW-Ms; Sat, 30 Aug 2025 11:08:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uruob-0001lE-06
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 04:50:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uruoX-0002B8-FZ
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 04:50:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756457424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wAPoSw6rQLlZFazB/GjF4cHC0Lnqbfyi3kyJ8ceBySE=;
 b=Wtg9koAUrLNqNyWudLhJoKk2W2wRXVf7C3k8hBws9qRPJdHcUZNZ+cPpP9N83w19VcvJl7
 Bg4ll2DoMRKy+DUTI5u4H4LdwXrtRgDX700PG/5lMxXaPgP+z9kOMEeIUgqarZqZCzdbnz
 WTIgQLbNRtiH3XtUcUb2a76OyeoQR/Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-wR45zAjfPYq1XomVIyQIhw-1; Fri, 29 Aug 2025 04:50:21 -0400
X-MC-Unique: wR45zAjfPYq1XomVIyQIhw-1
X-Mimecast-MFC-AGG-ID: wR45zAjfPYq1XomVIyQIhw_1756457420
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45a1b05d8d0so12854175e9.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 01:50:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756457420; x=1757062220;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wAPoSw6rQLlZFazB/GjF4cHC0Lnqbfyi3kyJ8ceBySE=;
 b=TJtrSEdY14rd0Q/hQoe3O9W8CB5o9r9hdkhevEVZZ5O8cQ5Dron3onhOFEHwBD94Ja
 vMSsXGloJ+azD/Y5IuT1XTt/C80qr8eRBva1VgX2V6fZCacVbStoEABzdkKg1bydhKyL
 uKw5QFUNXjbqpzDwzvaWj6VB+8OdjxVlY0ak3QFRtE436wBHXFSOe0nCHIkMg9Iw9SKt
 pWkjNL534WMbe3xc8RbSyJ3tGElakjZxOJdLrpBhoi9qMM6N0+Gfl7JB7XB/8mqD5ILx
 VYrvXwjyuUwUl9MWR6yzthCADRCtLeeGJFau0dBnK0+39ZZNIgUl6eIHtqSujvQ89phe
 T6LQ==
X-Gm-Message-State: AOJu0YynADW26fKgFWmH1e91PBi7gSBgVPlv3Vnfgj8+MMg9rmIowxm/
 AYED9sHb8Q/AugHPf5+Z2IxLjUIo3zm/jzolVeb4YeGivluMMy1RWj80gYioEu3HmBbnA3eC6C9
 l9lFoxGWPcl6wL2bU+MLcESFVaCBcYjAa30zpiwtFO9AwXfgxCJfBrOR2
X-Gm-Gg: ASbGncuFSsN0C6aR4sey80iaucHMOAkNMA9Pa9KF/W7UZBEVkUnoXUx6drKgmNUET9f
 eYIqerLWb+Np2pH8JjWhEOpcmkWoQdlVRCJbcSWNFWsdyOxJbZ/YD2EU+4+9f4ZaBeqFX0isZnK
 9nZhDo8IHmAGooeAfGTb7vXiUQb6GpBHxhT4OL4vB9kvOg1AcLSPcvexxZyC4zHMdmadeU8NC9/
 K1LsCiOiKkasf7UGUPl8f2Yw9O9hHKxtF2OgX4NVdSqjLw6X/FoeWsBogh9/qjoI7Vh1XaKw6KU
 M9FDzPY/1zDJDSRGWRRQgno2gorFXaRgO4r6GcZgZqhvchTd3zrCtolawew9hInj5xnb
X-Received: by 2002:a05:6000:2288:b0:3cf:d68e:54c3 with SMTP id
 ffacd0b85a97d-3cfd68e5884mr1269242f8f.28.1756457419834; 
 Fri, 29 Aug 2025 01:50:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoFoCQOFkb3/2S083lBijX9dDdOdvmfuyLfqvSy4M1RIyvQFi/Ym3eOmUickVvhVFcB0Wmhw==
X-Received: by 2002:a05:6000:2288:b0:3cf:d68e:54c3 with SMTP id
 ffacd0b85a97d-3cfd68e5884mr1269221f8f.28.1756457419307; 
 Fri, 29 Aug 2025 01:50:19 -0700 (PDT)
Received: from [192.168.0.6] (ip-109-42-48-43.web.vodafone.de. [109.42.48.43])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d0c344f6casm1351111f8f.36.2025.08.29.01.50.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Aug 2025 01:50:18 -0700 (PDT)
Message-ID: <28d768fc-eb5a-4550-940f-9f1a1dfc8d33@redhat.com>
Date: Fri, 29 Aug 2025 10:50:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Failure for ./tests/functional/arm/test_realview.py
To: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>
References: <56800442-3962-43b9-9b87-1b899077a24b@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <56800442-3962-43b9-9b87-1b899077a24b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 28/08/2025 00.49, Richard Henderson wrote:
> 2025-08-27 21:55:08,729 - qemu-test - INFO - Downloading https:// 
> archive.openwrt.org/chaos_calmer/15.05.1/realview/generic/openwrt-15.05.1- 
> realview-vmlinux-initramfs.elf to /builds/qemu-project/qemu/functional- 
> cache/download/ 
> d3a01037f33e7512d46d50975588d5c3a0e0cbf25f37afab44775c2a2be523e6...
> 
> This url is now stale, and is causing the functional-system-debian test to 
> fail.
> Do we have an alternate?

FWIW, looks like archive.openwrt.org is back online now!

  Thomas


