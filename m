Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B4F7A6966
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 19:13:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qieH9-0006ZA-94; Tue, 19 Sep 2023 13:12:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qieH4-0006Yj-Vd
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 13:12:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qieH3-0006Hm-Gb
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 13:12:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695143551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9WyNsOp0sisVK1C26O0GwH0mKN26/lh+6J4qTtT1JjQ=;
 b=Gd/zSLBt9LsE1vfsg3M3AOwsNN0oys07wufzwPcoAlTfiEkQ+KO0+T1NP2Cd9OVTlXwqDZ
 zJCy6ynvq4pF4krElhRarTeTEGysCVz/7kO2L8AL9DEcpaVioNHC5dIfczZyEQYc5yNYz8
 8sHJPfJfrEdx4bG+CL5cKn8nMn9SmNM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-VUYczwf-M7aYbAxbmDduTA-1; Tue, 19 Sep 2023 13:12:29 -0400
X-MC-Unique: VUYczwf-M7aYbAxbmDduTA-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6561142fe06so15749096d6.1
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 10:12:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695143549; x=1695748349;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9WyNsOp0sisVK1C26O0GwH0mKN26/lh+6J4qTtT1JjQ=;
 b=r9bKHDZ+6h2OeC4YWJ6punu8FCXzvGGlhdBkK72ooqnLOsKGo3TpGgSj9m7wCvs0aw
 9jSD1mq/YpHZFLsHUifvEQpOYWySOK5Snk/BiUkaa7v1Go7AFX98zo7mNroxerxuJzmw
 v8IxjoHkSY5W2STYQrW6W+wMDKtx4NqlNNatlgDYgwqgioRAtz5GGMFt7dnrnCBfoOAT
 bUyjf5ZMX6M8V1lhMk2uQWcHu2DyCs7iJQklJp3uGfmZjNxjoRd+OVR4UJgYCMb9ZeZv
 KSEbhahDfQZCcS4NifEDkSNOxzL/81yYZhzleGRA9ozzt8mYcpdtheOatIbX6v8QxvZl
 R0Eg==
X-Gm-Message-State: AOJu0YwKXYhHxOLF3qY6OccHf4C136CIiXLXedL6wMnK6rFN0kCDowJV
 NjLxy/dzIL72dohYecK14SYoCURi1qbc6haOwhHe+eSvLoO9M7Bb7YAYeJ1sG56PvnzuBIcWYeO
 uu6omT3jhkEpz3do=
X-Received: by 2002:a05:6214:f0e:b0:655:db84:adb3 with SMTP id
 gw14-20020a0562140f0e00b00655db84adb3mr15296740qvb.4.1695143549226; 
 Tue, 19 Sep 2023 10:12:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPZiGN8vnVWRi2buh7RMfuUsTssuUEd0I+0Gj0WWONbmj3iqzh7Nqbj8rk5H4p+k1s/iBEmg==
X-Received: by 2002:a05:6214:f0e:b0:655:db84:adb3 with SMTP id
 gw14-20020a0562140f0e00b00655db84adb3mr15296716qvb.4.1695143549006; 
 Tue, 19 Sep 2023 10:12:29 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 b18-20020a0cf052000000b0064f3f53bc9csm3389064qvl.94.2023.09.19.10.12.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 10:12:28 -0700 (PDT)
Date: Tue, 19 Sep 2023 13:12:25 -0400
From: Peter Xu <peterx@redhat.com>
To: Mattias Nissler <mnissler@rivosinc.com>
Cc: qemu-devel@nongnu.org, john.levon@nutanix.com, stefanha@redhat.com,
 Richard Henderson <richard.henderson@linaro.org>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v4 1/5] softmmu: Per-AddressSpace bounce buffering
Message-ID: <ZQnWech0biGUuTHh@x1n>
References: <20230919160814.3343727-1-mnissler@rivosinc.com>
 <20230919160814.3343727-2-mnissler@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230919160814.3343727-2-mnissler@rivosinc.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, Sep 19, 2023 at 09:08:09AM -0700, Mattias Nissler wrote:
> Instead of using a single global bounce buffer, give each AddressSpace
> its own bounce buffer. The MapClient callback mechanism moves to
> AddressSpace accordingly.
> 
> This is in preparation for generalizing bounce buffer handling further
> to allow multiple bounce buffers, with a total allocation limit
> configured per AddressSpace.
> 
> Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


