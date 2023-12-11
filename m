Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7742C80C14C
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 07:26:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCZjW-0003CQ-Vb; Mon, 11 Dec 2023 01:25:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rCZjT-0003Bk-RE
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 01:25:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rCZjO-0003BX-Sx
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 01:25:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702275929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B92j1vi8ew1UKhZyuu4lW/xfHKAnw7kV6s9IZdOSAcE=;
 b=D2w/AIeXR627Q8SsKzekDuKeXN3ToAWLe+UbBknMCBqHUKP/Xd1mbTKjeJkIQhn14Zg5ua
 YbTIRXDxKK72HBEpi7MeiA7Pj3QXmuJjOsw3Zz3ZDxLHlPXA8Xqv0RieZfzs1UXe9CwpcX
 ManTQPWPlpuRoJq/ZFbGWZU2CfMXc3E=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-nJwcRQAMOK2G3azCjBZzCw-1; Mon, 11 Dec 2023 01:25:27 -0500
X-MC-Unique: nJwcRQAMOK2G3azCjBZzCw-1
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-1d0a8bb0c2cso5657525ad.1
 for <qemu-devel@nongnu.org>; Sun, 10 Dec 2023 22:25:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702275926; x=1702880726;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B92j1vi8ew1UKhZyuu4lW/xfHKAnw7kV6s9IZdOSAcE=;
 b=Z5AlrimexSbdaMIyjQnurmEqc/IO2rZaIXjPtudqAAbCYb+8uUzi4khfRiCPm7tYIV
 UN4gRcXkeV5MII745gTpwtubcp9IWSy+rex6H5lAIQrTtt3uNAY3AqNVFq7jj4LEQZQZ
 7e6mZtkafnh70MSEVzCikdaRKbJwr+TCvzFCN8K3HhIhkRJHsoH3gRkQcqunKniUVY7p
 3Hw2K+pjFi8vttJ4u1yajKwi4rYq9kYmBfa3eQ/Vl1JxXRf9g5GKFy9Sc537nezEl5je
 fVF98ED9/QNUbzCFDfLOs/yoc8sNlpNpDFh6iE1bDeU9hGgmI7w10jOq3c0MIQ/7aCiu
 J/HQ==
X-Gm-Message-State: AOJu0YycGWTdAsaGy6htJVX69EiTXE6ZURlCYMEhpSCWlimdqwXqqNlP
 Y0gxBjPo9rkBKhgT1vIAPEpeIC0dhvU0jnrqzti+qmDEyEgo1RjZq7Z8oTDWhBkh3gh9x5P7Juc
 6PlhBYV+yyDKseEA=
X-Received: by 2002:a17:902:ab86:b0:1d0:9323:e43a with SMTP id
 f6-20020a170902ab8600b001d09323e43amr7531507plr.0.1702275926333; 
 Sun, 10 Dec 2023 22:25:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEuMGDiom9T0TNdf2yyaH4VErkS2XkeS1U8G3T4PzBd43h8ZFqoU1sSL/4hOft/IVGeXnjnlw==
X-Received: by 2002:a17:902:ab86:b0:1d0:9323:e43a with SMTP id
 f6-20020a170902ab8600b001d09323e43amr7531497plr.0.1702275925989; 
 Sun, 10 Dec 2023 22:25:25 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 w13-20020a170902a70d00b001cf6453b237sm5744463plq.236.2023.12.10.22.25.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Dec 2023 22:25:25 -0800 (PST)
Date: Mon, 11 Dec 2023 14:25:18 +0800
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org,
 Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH V7 02/12] cpus: stop vm in suspended runstate
Message-ID: <ZXarTh05TJmqZ-xX@x1n>
References: <1701883417-356268-1-git-send-email-steven.sistare@oracle.com>
 <1701883417-356268-3-git-send-email-steven.sistare@oracle.com>
 <2d6e4dec-bb04-46ea-bfa8-7006d8cc6dda@linaro.org>
 <a4ba60ff-be9e-4380-ab91-5b85e690c1d8@oracle.com>
 <5ffd8414-c326-436e-9009-ec5fa570070f@linaro.org>
 <db299749-3aa0-45d4-808c-1002fa75704d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <db299749-3aa0-45d4-808c-1002fa75704d@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Wed, Dec 06, 2023 at 10:09:32PM +0100, Philippe Mathieu-Daudé wrote:
> What about runstate_is_vcpu_clock_ticking() then?

The problem is vCPU clock ticks can only be one part of "VM is running"
state (no matter whether vCPUs are running or not).  I'm even thinking
whether cpu_enable_ticks() should one day be put into a vm state change
notifier instead to be even clearer that it's not special (I hope I didn't
overlook its specialty..).

Thanks,

-- 
Peter Xu


