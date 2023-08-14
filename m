Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 209DC77B726
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Aug 2023 12:57:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVVFP-0001A4-SZ; Mon, 14 Aug 2023 06:56:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qVVFM-00019Z-0V
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 06:56:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qVVFK-0001XG-5r
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 06:56:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692010583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3JF9hso57G/NlGbq4sxMqwrrpshkB6ZeL7DNm1mHHXA=;
 b=ETFmK2xuIPnDb5caZodD8/P3WrnFBkIbLa6LnRF403E38d7pv6WcADUG94VIar7OJgsT1Q
 4DrseiUCLtqOiPpQE2aS0wLofXYwfHkIwblU00bigpLrhzpPolZMit06JEm28oyhHaQ7oW
 5sbSTYNc/S6Smxb8qQC1/WUNYvN07UA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-9eS8S51qNvuwrXxpXcnb1A-1; Mon, 14 Aug 2023 06:56:22 -0400
X-MC-Unique: 9eS8S51qNvuwrXxpXcnb1A-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3fe232ba9e5so27499645e9.2
 for <qemu-devel@nongnu.org>; Mon, 14 Aug 2023 03:56:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692010581; x=1692615381;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3JF9hso57G/NlGbq4sxMqwrrpshkB6ZeL7DNm1mHHXA=;
 b=cg6borKKUtEykeEs7JK5RUUdMbX6vo6ICNoLtPVaOt4rhSYICHltQXM+LRoFFNN5QD
 FHfCuxHIjmRKS5AiAngGMKCPKoj5aKHl04/5WC7u2392zsRZJZ7uOMnjgYIsV+St18NU
 NVohWrnbUVqMgNVsrfYn5L6IE8XaQPpU/ba9pWzNxkO96D/SbHtHwCadj6aUvkA1Ru0N
 i+jmvE40mCXquOsUFaDnUdsdmglko1W8a0t0KpciCRBQp3mbbskU2+4YUl0e3FYIbJ1I
 fMtxjpYNJMWNp7xUe5nqB6f2CD/M2wbtAr9gTCGjR0oPL8OXJeUQYty3/UJUtynbTSOl
 lRgw==
X-Gm-Message-State: AOJu0YzMO/0LldKY/KGM/w7c1ksN6tfoqF68q2dF8HoxwswLO+BsmIxo
 mcwD/WA4J7JQJnnYsMpXjruWBNtu7YALzIDW1GqJRSFGjWKjdZxrv6WhfVww+0956BiLMoayeXA
 Pdvc9u5/25mo37DegS3KBcsw=
X-Received: by 2002:a7b:c4d0:0:b0:3fe:173e:4a54 with SMTP id
 g16-20020a7bc4d0000000b003fe173e4a54mr7596640wmk.17.1692010581173; 
 Mon, 14 Aug 2023 03:56:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEapxpIPv2hF9OijyQjpsjm9/9QMeR2+JQueZlZ/6KqMusg8gp5D5VnFDZh9imuwhkbhQkS/A==
X-Received: by 2002:a7b:c4d0:0:b0:3fe:173e:4a54 with SMTP id
 g16-20020a7bc4d0000000b003fe173e4a54mr7596628wmk.17.1692010580894; 
 Mon, 14 Aug 2023 03:56:20 -0700 (PDT)
Received: from [192.168.8.105]
 (dynamic-046-114-244-033.46.114.pool.telefonica.de. [46.114.244.33])
 by smtp.gmail.com with ESMTPSA id
 h18-20020a1ccc12000000b003fbd9e390e1sm17039931wmb.47.2023.08.14.03.56.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Aug 2023 03:56:20 -0700 (PDT)
Message-ID: <ef2fb553-fbac-7947-7be0-cdc7801b7a4c@redhat.com>
Date: Mon, 14 Aug 2023 12:56:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: qemu-system-m68k: ../hw/scsi/scsi-disk.c:557: scsi_write_data:
 Assertion `r->req.aiocb == NULL' failed.
Content-Language: en-US
To: Waldemar Brodkorb <wbx@openadk.org>, qemu-devel@nongnu.org
References: <ZNiKYwbkk5zwlLB5@waldemar-brodkorb.de>
Cc: Laurent Vivier <lvivier@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <ZNiKYwbkk5zwlLB5@waldemar-brodkorb.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -64
X-Spam_score: -6.5
X-Spam_bar: ------
X-Spam_report: (-6.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-4.359, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

On 13/08/2023 09.46, Waldemar Brodkorb wrote:
> Hi,
> 
> I am using Qemu 8.0.3 and getting this error:
> qemu-system-m68k: ../hw/scsi/scsi-disk.c:557: scsi_write_data: Assertion `r->req.aiocb == NULL' failed.
> 
> It happens f.e. when I extract the glibc source code inside Linux.
> Linux 6.1.44, glibc 2.38 is used for the Linux system.
> I am starting qemu this way:
> qemu-system-m68k -nographic -M q800 -kernel /home/wbx/openadk/firmware/qemu-m68k-q800_glibc_68040/qemu-m68k-q800-archive-kernel qemu-m68k.img
> 
> What can I do about it? Why this is happening on "heavy" I/O usage?

Is it a regression? I.e. did it not happen on older versions of QEMU?

  Thomas



