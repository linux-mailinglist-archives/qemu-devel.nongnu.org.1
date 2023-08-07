Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 474B37725F3
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 15:38:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT0PU-0007n7-01; Mon, 07 Aug 2023 09:36:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qT0PS-0007mq-AC
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 09:36:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qT0PP-0005hW-RS
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 09:36:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691415390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IwvbOyxuGsO7lIfGXiNJNQzpeLnrI7wd8am9nReRVnA=;
 b=Ai/p6y8T/puN0SnMy/qbdPOK7F66wyBceP8/6tcgEc7ObqE7RN7C3NEw5qRtLUtyJeOZfl
 c89CqvPDxd/1sh9ubxCe8kBUdXnCB0L3J7ne2/ppLrkCKJ8nrXzdDkemf/8U2z0+R9oxkQ
 9WnzwE/BW4REGiBd3AH7ipoAJLt+59c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-7IF3bPwHNYuXnzDStsa4JQ-1; Mon, 07 Aug 2023 09:36:29 -0400
X-MC-Unique: 7IF3bPwHNYuXnzDStsa4JQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fd2dec82b7so25362275e9.2
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 06:36:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691415387; x=1692020187;
 h=content-transfer-encoding:in-reply-to:subject:references:cc:to:from
 :content-language:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IwvbOyxuGsO7lIfGXiNJNQzpeLnrI7wd8am9nReRVnA=;
 b=La4FF50yvgdkY9BBMgW6nztJF8K0aYe09mySibRUJaHwqHwuLT/WSCU+mBSRcru/nQ
 SDZNc9GP9IZJDM7g5jieVRbkcKP7I55i9GW5hiQQXxBcPngSyRjyuKPkDZGMJP1nY9VJ
 dRRZqIM16Ha89jBLPXms83Z1l1rXQi4JmLFFV+abWA1N/ZcX11JpE6/CppeH3mCOxwyv
 VcS7LYzOuoLgZ8injXO8LkmsJYNv3sjqpz5+ZsQZ4FuTYl2Br0hCx2vn0vCLX5lBI3YK
 fnjPyUw68hzyBTcXYjQhtLcOi0xUOe5DwSG5fhZa5/QItj7uToMcS4q+9i01hQlTcRGh
 7Auw==
X-Gm-Message-State: AOJu0YzTe6Y9HHrzCLnMH7/nid7tkO8+iDcvYQ4VMvxavGY2lkrsTjZR
 Z/HMgCF3gSjAKoc+bO6QFsSa7tBkFI78lgduSg5V8p++eZiMoz5Tp1bu09SrfnNUklZXmXeOzaA
 zspYLfzDLg/s0IGbXrLJQCZ5Hri3EMfvImm9sf7mnYi49ytn9/iaQ4pckK8SnsUrVKc59v8BFwU
 I=
X-Received: by 2002:a7b:ce0e:0:b0:3fa:8db4:91ec with SMTP id
 m14-20020a7bce0e000000b003fa8db491ecmr6063805wmc.10.1691415387777; 
 Mon, 07 Aug 2023 06:36:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkInfAxi9vz8bhgJEMxGt2hVRBUNM7igvJMYhvuVlvL6Z6BsKRbvLf0Rk8NU27RTWAIQyT7w==
X-Received: by 2002:a7b:ce0e:0:b0:3fa:8db4:91ec with SMTP id
 m14-20020a7bce0e000000b003fa8db491ecmr6063788wmc.10.1691415387428; 
 Mon, 07 Aug 2023 06:36:27 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045?
 ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.googlemail.com with ESMTPSA id
 l26-20020a1c791a000000b003fe4548188bsm10659260wme.48.2023.08.07.06.36.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Aug 2023 06:36:26 -0700 (PDT)
Message-ID: <3b55b9e2-877b-7af0-3543-3dc6f239cbbb@redhat.com>
Date: Mon, 7 Aug 2023 15:35:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org,
 Joel Stanley <joel@jms.id.au>
References: <20230807094807.471646-1-pbonzini@redhat.com>
 <20230807094807.471646-4-pbonzini@redhat.com>
Subject: Re: [PATCH 3/3] configure: unify case statements for CPU
 canonicalization
In-Reply-To: <20230807094807.471646-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.809, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 8/7/23 11:48, Paolo Bonzini wrote:
>     armv*b|armv*l|arm)
>       cpu="arm" ;;

Oops, sent a stale patchset. The only difference is this extra ;;

Paolo


