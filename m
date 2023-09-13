Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D1779E4EF
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 12:30:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgN7d-0006aU-1s; Wed, 13 Sep 2023 06:29:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qgN7b-0006aM-7Z
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 06:29:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qgN7Y-0004mn-WA
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 06:29:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694600959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0bxFVe/E2XvfrFqG8Yrr1bPRLJ8gbzxCcYIWyf9wMMg=;
 b=SEtO//4XqdqmKw26OrP4dGeP0BtkzRCKMU1sOZYgw0lLSlE6xI4Jncj2P9cdecJnkNg8ao
 iK3uuFAbgQrlBSiJrrk9htTKdzJE8BU4iu0rqF7CRd8+w+qMDeqo2W5idS3CL4ufPxo27t
 8EIscCNvwbL0GoyrIV5s1Y/oMj9Yz1E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-NZqXdayuOOi5qMoAjJDGSw-1; Wed, 13 Sep 2023 06:29:18 -0400
X-MC-Unique: NZqXdayuOOi5qMoAjJDGSw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fd0fa4d08cso49992605e9.1
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 03:29:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694600957; x=1695205757;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0bxFVe/E2XvfrFqG8Yrr1bPRLJ8gbzxCcYIWyf9wMMg=;
 b=wh3vm3QA0gWgDQba/peTghNWqrzWG6o5deAhpQjXBJ3pPqo0ioHsHWPidDAYH0ZCqL
 2QxRLqfCOD7NUGjhHQsuZ06GHlEcq1sJY0RVjEOZEuZGTXjzys64fSU7AfRl5nMD4bYQ
 2geswUdoJ0i7kYG427zTW3NgbNzuGMdIrZ1QtGa6U32YsrjPMgIvKWMn24Akk3g8oA3z
 JncaIx/5qmOUsY/zp8QnqSo3ZHD9q+W0hAL540E9BRyCskYRLVZ53T1b7wXuYR+rxYec
 ei19RQjujua7a7rT5TdkRAuE80jeFBYN3mjxMNOsoL6npiCPcC6cs0pwgxYR5XvRJwRG
 6dTg==
X-Gm-Message-State: AOJu0YxuWO4w+cDPtRUUFJJYaUaSB2C7PmnYbl6gjmtvsMpAxhQpwT7o
 ASn7ug97TOC0bNICxAneER6nZJlxWYbPlOSZbkMIinov7W04vBN1nScIRpafYdMr2ZWd1PqzXVX
 qLdQtCJVNX21o8YY=
X-Received: by 2002:a1c:7213:0:b0:401:d5bb:9b40 with SMTP id
 n19-20020a1c7213000000b00401d5bb9b40mr1791337wmc.15.1694600957305; 
 Wed, 13 Sep 2023 03:29:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJQ20OnDZTTPIGLgVTuejcFW7U3fILnen/CmHvty2+jekejpqdkNJ3ZrDotViC4vJgjVrZ9Q==
X-Received: by 2002:a1c:7213:0:b0:401:d5bb:9b40 with SMTP id
 n19-20020a1c7213000000b00401d5bb9b40mr1791319wmc.15.1694600956978; 
 Wed, 13 Sep 2023 03:29:16 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89?
 ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.googlemail.com with ESMTPSA id
 a16-20020a5d4570000000b00317f70240afsm15203183wrc.27.2023.09.13.03.29.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Sep 2023 03:29:16 -0700 (PDT)
Message-ID: <7b544940-0cf2-652e-732e-934dfac63182@redhat.com>
Date: Wed, 13 Sep 2023 12:29:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 0/6] target/i386: Restrict system-specific features
 from user emulation
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 kvm@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
References: <20230913093009.83520-1-philmd@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20230913093009.83520-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/13/23 11:30, Philippe Mathieu-Daudé wrote:
> Since v4:
> - Addressed Paolo's suggestions (clearly better)
> 
> Too many system-specific code (and in particular KVM related)
> is pulled in user-only build. This led to adding unjustified
> stubs as kludge to unagressive linker non-optimizations.
> 
> This series restrict x86 system-specific features to sysemu,
> so we don't require any stub, and remove all x86 KVM declarations
> from user emulation code (to trigger compile failure instead of
> link one).

I'm still not sure about patch 5, though I'd like to have something like 
patch 6.  But fortunately patches 1-3 are enough to placate clang, so I 
have queued them.

Thanks Philippe!

Paolo



