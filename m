Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D39DEB33E1C
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Aug 2025 13:32:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqVPs-0002uB-Kk; Mon, 25 Aug 2025 07:31:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uqVPm-0002rp-Jq
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 07:31:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uqVPg-0005ch-6f
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 07:31:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756121454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=38BdOppienMWSF5lbjKOv0nyGRWpeeREOGI++PRCcvk=;
 b=M5I/2LX0O5oTE+13OAMcmiV26dVElkY9fyU1mHGB7m6a2bE9F2G5cYaAHDKUCHMZHuLAIW
 IAgpg/MUGN0wxpuXrNe/bpo1JcuR/q2jOpP4fmaDpgLNzmpOr2YRZYH2QFND1mAvbe3GzU
 HkkclbIvxQdZnz40H14utfU/7LDiSPA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-5WGX03rJM7WUgDl1nTc46A-1; Mon, 25 Aug 2025 07:30:52 -0400
X-MC-Unique: 5WGX03rJM7WUgDl1nTc46A-1
X-Mimecast-MFC-AGG-ID: 5WGX03rJM7WUgDl1nTc46A_1756121451
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4b109affec8so102783171cf.1
 for <qemu-devel@nongnu.org>; Mon, 25 Aug 2025 04:30:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756121451; x=1756726251;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=38BdOppienMWSF5lbjKOv0nyGRWpeeREOGI++PRCcvk=;
 b=TbmsMfqjBDilnLT+dxQD1aL7mguzxDaDQBRk7/hoyN3T/euEWv5are8Mka0B6syfID
 EXMFeVQx5XEBPTSjsoWnQXhbHKEyNJh3TZ29OdDhqthUKVVgLoqUjJlT6GAIbHckns5z
 Vnd63MZUIDFjIkdWeTjqN9frwZ095cyqCQVITT5ZjKP9odQv/Mu5DgzHz76xkgR6n1VL
 eOOALU85HdSvqm1RWLnr7whwZDGkBA48BpxwWpAGD692NL+d3+EMB8x4BCLG9AraJta1
 V4H4/VmuKgcud0BfJNhyXLk2mbLz2JM11P8Pe58MgF6PpyzH/nxRRcvcvco7nfBETuUX
 QNHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaHmonBrZT3QepvatRZIkr2rkxt0nOgDGK2Z+Qp5e2AWgXfetTVKeyWIYXENLg83hm5A8l9QYYKod/@nongnu.org
X-Gm-Message-State: AOJu0Yzm0Z/VbkguutB1TusQXq3o7uxqt+LPWZHdG1cU0NKOjVCsB0ez
 Ha+pCqk9+/cFmwARLNZ3MU0mJfR9p9lrr+YUrR1CU73cgSH6m2TG/CS/ctWG29xHb6p6/rAYwsc
 10C4yURHa5+ltjR/rRn2F2rAMze1QM2TJGP5UjqbUTMT/OcvBrYDHxqsm
X-Gm-Gg: ASbGnctRswFPXskoxtjQ4MnQxd5anoaZ/5ZIZH3rJKPcd0eght8O+XTqiW+ic3lJHod
 bEsBHNctNhqL/EomtKT45PMGBiMiEgQD058pjIuBbfQvHcp6JqsIYzx1fs8JJcN3/LxspqeSe0R
 eP8ks/13wsh0//wMRRaubKkvqd5xNM12v1RexoCyBRdoMHTGZBqyyRXMOcCQSdXJPuV6dcw0ut+
 buMMxZiuF5k8ZkAhOjmc31n26IbaW4JM8pNiuzOlzVig2nO04pZYXkridJu+Df1Lx84bwdzGPoq
 ELBOdHG6XfkmwV+Po/slvB7rLccVw94xnT1SHGN5NYYKP8pgI15oBeVg1e0ecKpjK7V1WhCdKic
 fmQc=
X-Received: by 2002:a0c:f10f:0:b0:70d:a7a1:debe with SMTP id
 6a1803df08f44-70da7a1e55emr71186726d6.46.1756121450772; 
 Mon, 25 Aug 2025 04:30:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFppyERRSZFI9YOzwjXsCVG0o/HeCgDxFzTrSc3MGWWgRRgUJn34CtVmGqKE294DKv/IkD2pQ==
X-Received: by 2002:a0c:f10f:0:b0:70d:a7a1:debe with SMTP id
 6a1803df08f44-70da7a1e55emr71186256d6.46.1756121450144; 
 Mon, 25 Aug 2025 04:30:50 -0700 (PDT)
Received: from [192.168.0.6] (ltea-047-064-112-084.pools.arcor-ip.net.
 [47.64.112.84]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-70da72aff63sm44029886d6.51.2025.08.25.04.30.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Aug 2025 04:30:49 -0700 (PDT)
Message-ID: <7b1222ef-df18-4770-b218-b71cacb441e9@redhat.com>
Date: Mon, 25 Aug 2025 13:30:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] tests/functional: add tests for SCLP event CPI
To: Shalini Chellathurai Saroja <shalini@linux.ibm.com>,
 qemu-s390x mailing list <qemu-s390x@nongnu.org>
Cc: Daniel Berrange <berrange@redhat.com>,
 qemu-devel mailing list <qemu-devel@nongnu.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>
References: <20250812123124.382696-1-shalini@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250812123124.382696-1-shalini@linux.ibm.com>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 12/08/2025 14.31, Shalini Chellathurai Saroja wrote:
> Add tests for SCLP event type Control-Program Identification
> (CPI) to s390x CCW virtio tests.
> 
> Please note that these tests are skipped as the guest OS does not
> trigger the SCLP event type CPI when the command
> 'echo 1 > /sys/firmware/cpi/set' is executed in the guest. I
> believe that the guest OS must to be updated to support the SCLP
> event type CPI.
> 
> Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
> Suggested-by: Thomas Huth <thuth@redhat.com>
> ---
...
> +        try:
> +            event = self.vm.event_wait('SCLP_EVENT_CTRL_PGM_ID')

As far as I can tell, SCLP_EVENT_CTRL_PGM_ID is an *SCLP* event only, but 
you're trying to wait for a *QAPI* event here instead. That's two completely 
different things, SCLP events are something between the guest and QEMU, 
while QAPI events are between QEMU and the monitoring program (i.e. in this 
case the test).

If you want that QEMU generates such QAPI events for the monitoring program, 
you have to do something similar to commit 1cfe52b78240679 and add the 
qapi_event_send_... function to the right spot in your code.

  HTH,
   Thomas


