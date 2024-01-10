Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11894829564
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 09:50:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNUH7-0007mj-E7; Wed, 10 Jan 2024 03:49:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rNUH4-0007mF-Ux
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 03:49:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rNUH3-0007fM-Ip
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 03:49:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704876560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U9Ay0uW4aKzseVVG9+XAeotn3kB9O7PfaKW+PiV4K1A=;
 b=RSM7sZwjXa9rR77IGZuEvJ1b9AgYAtoVEqw5MQiBN1ivQd+Z0ckk5hs1z+sEI/riTt6nbV
 jd6ZgEm5mB3SzOqeEfaQb406vCRv1ak8hATShFlz0NM9rWVO17OT4JoOzMNt21dk3Imd81
 6+ZTSz6JHkcg5+qR1Gpde27r12LvBA8=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-83VQVlk4Ntml-wCpwgNNbQ-1; Wed, 10 Jan 2024 03:49:19 -0500
X-MC-Unique: 83VQVlk4Ntml-wCpwgNNbQ-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-6d99cdbeb9dso1032775b3a.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 00:49:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704876558; x=1705481358;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U9Ay0uW4aKzseVVG9+XAeotn3kB9O7PfaKW+PiV4K1A=;
 b=AQlHtMrPX0VkdqH1Ln8in8XhUWFGvklmRJNY4QvhPdlF8Vwy51qLWq+QIpebjuprb7
 HL/bHEYWArxt3UmlCP7R9rF3YM/RPtBm4vDnAphgSNgjCtzmDettJpI9ymr4KWRGAF5p
 FSgAgLBPZLKz+H5vdvWjgS0m9b5JqZZbO4K2c3+3Cl42oWZUHtxYsapPICPgbEi3y3yH
 z+18ZAKBenWqOC3OvZoL2TBFOsr32wUEnV716w2a6HQS30/mKcoEq/SgOEb2cHpqznRn
 E5HzDINFF57MxdqCTZt3aPDvSh9M5unHYZ8IpWplnf8W3MJFQuEEPlmaNyPKF5QtdZgZ
 PEXA==
X-Gm-Message-State: AOJu0Yww2mLHMKk0P3hSSguv+Ahm4eu7/f1tZolQ0s0R2/qg6utkWg2w
 44LqGzUG2yIuBC33bsutKlRsjyFXfagj/9QUZobfDeoSFHFGGy2DrAelX959PpnA0u3x4csV0Nc
 3q/w1wyDTkrFK6qzTJj/LAyQ=
X-Received: by 2002:a05:6a00:2e90:b0:6da:838f:b004 with SMTP id
 fd16-20020a056a002e9000b006da838fb004mr1679808pfb.1.1704876558194; 
 Wed, 10 Jan 2024 00:49:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEETlpETOXXMyWzVNvJTxHH7gpPiWAKZd6YX3lThRbNqNgVGehGoSPYJBsExrRwl9MqGAuwqw==
X-Received: by 2002:a05:6a00:2e90:b0:6da:838f:b004 with SMTP id
 fd16-20020a056a002e9000b006da838fb004mr1679798pfb.1.1704876557895; 
 Wed, 10 Jan 2024 00:49:17 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 p29-20020a056a000a1d00b006dab0d72cd0sm2961537pfh.214.2024.01.10.00.49.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 00:49:17 -0800 (PST)
Date: Wed, 10 Jan 2024 16:49:11 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Nikolay Borisov <nborisov@suse.com>
Subject: Re: [RFC PATCH v3 01/30] io: add and implement
 QIO_CHANNEL_FEATURE_SEEKABLE for channel file
Message-ID: <ZZ5aBzsrV55hAmJX@x1n>
References: <20231127202612.23012-1-farosas@suse.de>
 <20231127202612.23012-2-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231127202612.23012-2-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.493,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, Nov 27, 2023 at 05:25:43PM -0300, Fabiano Rosas wrote:
> From: Nikolay Borisov <nborisov@suse.com>
> 
> Add a generic QIOChannel feature SEEKABLE which would be used by the
> qemu_file* apis. For the time being this will be only implemented for
> file channels.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


