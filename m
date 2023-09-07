Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B90797197
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 12:58:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeChl-00067M-Tz; Thu, 07 Sep 2023 06:57:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeChj-000679-7W
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 06:57:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeChd-0006Wz-FZ
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 06:57:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694084254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sfRZHG2msUpbUHrX6YH9aDFB0zh8D2vPywlIrcQ9XaY=;
 b=XiUaFG+Uel8StB1R1Q3gUq8cCPmwxRWE9gj3UYG7K1ZUJ55L4tGev+WxHHR05c3vxQcnPu
 Rnx5H642Zrfrsx/UusicUqLwiX1UcV6tVRSNtvBTIUV5Lt2yvuRk/o91Tb23xVTcc1xdDO
 1XZsK1qlAPtZ5FQPX4Wwb7GRawRvecY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-Gr-TbIClN6aZy3NOYd36AQ-1; Thu, 07 Sep 2023 06:57:33 -0400
X-MC-Unique: Gr-TbIClN6aZy3NOYd36AQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-317a84a3ebeso820942f8f.0
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 03:57:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694084252; x=1694689052;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sfRZHG2msUpbUHrX6YH9aDFB0zh8D2vPywlIrcQ9XaY=;
 b=gXeoSFPu2p0LqnArvwd4VV/KDhZhTvddpGmOSoOXHJGgNM5mmdEk9riDQZ1AUTwCJM
 OdaaDaMbPxG1bYOC4fMNgrzMzJTF3WWWq5FHNrHUZ6KPDyqS3MHl2r9COxW0+JE/+dmo
 QxAXv+amnsYZuD1PCoAe6oKkpEBkc7DrupCUWpA+WJ1GNesEPR1Qeu50HV321y4Jwkoc
 afcpE1fO1G6cdmY0dlzxfrmTFj/cI1AozkV9QCh/sBUhYEpE7ZKMMOGofVC2Ae3Rd42p
 t8N0kAcw3WqPBBcAqJxXKpTmBWtrnxf9fF95PZT5ee6+7D2G1D1+gvwq9BQFsYzJnX0z
 Hg7Q==
X-Gm-Message-State: AOJu0Ywk9sT/j034YYEEP+Bj3U4ZuntREGWqv3yD9q0zU/0Wm3MTPN2x
 hmR/IoTl7Gi/Gz0S8VWqgY7S4w9uMRSG0Qm+SSx3xRRmtMZ9gtjGhaaJm4e4luKrf7YwgVndmbQ
 BmO8BFNciWe4kJkc=
X-Received: by 2002:a5d:4683:0:b0:31d:cb4b:ccd3 with SMTP id
 u3-20020a5d4683000000b0031dcb4bccd3mr1661050wrq.21.1694084252050; 
 Thu, 07 Sep 2023 03:57:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCqVmK7nf43SF3hB/17KvFoHxA4wPwqJ6vJmhzvwzL3zJMahHFORLfutTeO1fDXhTFvc8bFQ==
X-Received: by 2002:a5d:4683:0:b0:31d:cb4b:ccd3 with SMTP id
 u3-20020a5d4683000000b0031dcb4bccd3mr1661039wrq.21.1694084251754; 
 Thu, 07 Sep 2023 03:57:31 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312::1fc? ([2001:b07:6468:f312::1fc])
 by smtp.googlemail.com with ESMTPSA id
 l4-20020adffe84000000b003176eab8868sm23051001wrr.82.2023.09.07.03.57.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Sep 2023 03:57:31 -0700 (PDT)
Message-ID: <5d0119f5-5175-fa0d-7a9e-1558478997c5@redhat.com>
Date: Thu, 7 Sep 2023 12:57:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/5] contrib/plugins: Build fixes for Darwin
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20230907105004.88600-1-philmd@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20230907105004.88600-1-philmd@linaro.org>
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
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 9/7/23 12:49, Philippe Mathieu-Daudé wrote:
> - Fix string formats
> - Link with GLib
> 
> Alex, Thomas: FWIW, plugins aren't build on CI.

They become tested with my patch "configure: unify recursion into 
sub-Makefiles", which is how I got into this business.  So I'll queue 
these patches and include them in my next pull request.

Paolo

> Based-on:<20230907101811.469236-1-pbonzini@redhat.com>


