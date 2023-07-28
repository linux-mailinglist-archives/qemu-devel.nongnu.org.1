Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F328766FFD
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 17:01:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPOeA-0008CM-7t; Fri, 28 Jul 2023 10:40:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1qPOe7-0008C7-Ig
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 10:40:47 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1qPOe6-0005Dh-26
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 10:40:47 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1A72D1F37E;
 Fri, 28 Jul 2023 14:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1690555244; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2LktwbHhQsvpyD9ZZwT2kmZn+UBvTeQ9qBaOo/N7n/I=;
 b=psXryzO6K/n+CeGWWNxnw3FU8EhESfziVML1Vgw41s7AjcA2bZOSRjAyvqQU5BSoH6EQnB
 vDIGDXG5oQHTj4nhZ7DLlzHnw0bqqAwFQ8kG1Zmq1eibxdB9ul3E3mg8xPj5njCEM1764v
 2yfbDPebeQedAun5q+oBMI/PJAt4dCU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1690555244;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2LktwbHhQsvpyD9ZZwT2kmZn+UBvTeQ9qBaOo/N7n/I=;
 b=SxAtKU+XwXXlPG5Ft2mqpi+YDT3O1dPp1b97zwqJp+GHISo+dSxnwLDwASQh1JX1uoILU7
 YII1xmjQjRwk8RDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E10BA13276;
 Fri, 28 Jul 2023 14:40:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id NRXSNGvTw2RcLQAAMHmgww
 (envelope-from <cfontana@suse.de>); Fri, 28 Jul 2023 14:40:43 +0000
Message-ID: <d6e0b264-d56a-92d0-a663-9ee3339ea14f@suse.de>
Date: Fri, 28 Jul 2023 16:40:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: assert fails in s390x TCG
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
References: <eaec32e3-d56a-e6a7-fcbe-860948e79658@suse.de>
 <def2df0d-fb58-8e67-a0eb-7d646da3be42@linaro.org>
 <0e06f694-7aeb-66d1-48d8-317a93f8f741@suse.de>
 <2a417aaa-9ef9-6e24-cc54-e76e2d25b968@linaro.org>
 <77b0a57e-68f6-8515-b3fa-3ec9988894bc@suse.de>
 <16a9cdba-2f84-7d38-aadb-04524fee51e2@suse.de>
 <a1004734-5eb1-032a-f597-c77aa32eee03@linaro.org>
From: Claudio Fontana <cfontana@suse.de>
In-Reply-To: <a1004734-5eb1-032a-f597-c77aa32eee03@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=195.135.220.29; envelope-from=cfontana@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.094,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 7/28/23 16:28, Richard Henderson wrote:
> On 7/28/23 07:23, Claudio Fontana wrote:
>>> It is a test environment for building packages, so the guest at the time of the error is running ./configure for the package swig-v4.1.1.tar.gz
>>>
>>> checking build system type... s390x-ibm-linux-gnu^M
>>> checking host system type... s390x-ibm-linux-gnu^M
>>> checking for a BSD-compatible install... /usr/bin/install -c^M
>>> checking whether build environment is sane... [New Thread 0x7ffea3fff6c0 (LWP 116436)]
>>> [New Thread 0x7ffec14e26c0 (LWP 116437)]
>>> [New Thread 0x7ffecf73e6c0 (LWP 116438)]
>>> [New Thread 0x7ffecde2c6c0 (LWP 116439)]
>>> [New Thread 0x7ffec2beb6c0 (LWP 116440)]
>>> yes^M
>>> checking for a thread-safe mkdir -p... /usr/bin/mkdir -p^M
>>> checking for gawk... gawk^M
>>> checking whether make sets $(MAKE)... yes^M
>>> checking whether make supports nested variables... yes^M
>>> checking for s390x-ibm-linux-gnu-gcc... gcc^M
>>> checking whether the C compiler works... **
>>>
>>> So I presume we are in:
>>>
>>> AC_PROG_CC
>>>
>>
>>
>> I am rerunning this over and over, and it seems it always aborts there in the same place.
> 
> You didn't say what the host is, only qemu-system-s390x.
> Am I barking up the wrong tree looking at s390x host?
> 
> 
> r~

sorry, no it is an x86 host in this case, running openSUSE Tumbleweed.




