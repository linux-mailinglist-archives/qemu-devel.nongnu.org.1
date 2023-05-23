Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC93370E99C
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 01:29:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1bRn-0002eJ-5x; Tue, 23 May 2023 19:29:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1bRl-0002e0-A9
 for qemu-devel@nongnu.org; Tue, 23 May 2023 19:29:41 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1bRd-00020I-Hw
 for qemu-devel@nongnu.org; Tue, 23 May 2023 19:29:41 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-64d2981e3abso97322b3a.1
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 16:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684884572; x=1687476572;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ffk+d/CO6pYGxGh9Rp7TzGhKn2HVBcAoJ/BQgXGsqZQ=;
 b=iQljZEvdNQUxFlQJEJIT9UdT8TSeXiv4QThaUk3euoY/peNFzUdJUxgVIHJyOVjMAL
 UFAHkPMfAcW0ja2VFQdEYwU/xR88kfPzBP37j1NJzUs3h72iDJ/sbQW1LXKIrUZ4IRWR
 OBWJiFEo+5pY65HJ1/E/k+0gu8tTAbzbk359r7sMsLhYC8DsPPH8RTguSUcksMmAcSzn
 lAWFuDTokdeFpdU82gK4GeqsjX3wasiUzZ8XIj7tmz4KVhHiOLeu4B/c9uZM0Fco12SR
 tFbRKlBfX2ob2hzIEA4qoDtXQyyGADg0rT03+8w+NZVLxvH9M/zXoy7QF0pAUVOusCVP
 +ANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684884572; x=1687476572;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ffk+d/CO6pYGxGh9Rp7TzGhKn2HVBcAoJ/BQgXGsqZQ=;
 b=G+F4ZyIJRNwbc9OH9k97g3e6XtVjaPLuhSzZAnw1BGh+8bbIc6LW7jZi2ugok5ieyR
 BLo8k9WlERdsvb++H4khU8nYTdPZfz6R25rk1Y97rXISYgUWJMo+M7dfo+cLllIKGmjG
 c2HfdxrdJ3uBxesfl2FnB+kZO5hsY1IV1HuEJrcnPVEIKtMhi/Y5es27Ik7kydknKd0c
 9ONexOPNMwiP5Jqvmv+lwnhgDWMf6GfslkllCXRdmWQCF+UtosDqhjhnmG1gWRS0VdSh
 9FJSCqJRwDwbSnhQnHB/N7fmSafPQHy1Tlo/yZTXybuQNPIHfmnH0Pmt8TVx7stpbEVW
 2ZzA==
X-Gm-Message-State: AC+VfDwyQs5SA8SWEV1G3+6YpmvYSkvC1r5iy3yEsLRc7j4ajcnyDDVE
 zLds5cY3w0XpjvMkDMVFQetR5g==
X-Google-Smtp-Source: ACHHUZ4r3kPEwQOy3W7G4zoXccIOCql6XR0bFFXe/f9UM8rs+VsYfmB2bfk7pd3kbNfUY2T8910cqA==
X-Received: by 2002:a05:6a00:1701:b0:643:ba77:f265 with SMTP id
 h1-20020a056a00170100b00643ba77f265mr854142pfc.25.1684884572085; 
 Tue, 23 May 2023 16:29:32 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:c13a:d73:4f88:3654?
 ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 l8-20020a62be08000000b0063f1a1e3003sm1355825pff.166.2023.05.23.16.29.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 16:29:31 -0700 (PDT)
Message-ID: <c176f238-92c6-c9de-5e18-5db5353dcdd2@linaro.org>
Date: Tue, 23 May 2023 16:29:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 09/11] hw/virtio: Remove unnecessary 'virtio-access.h'
 header
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Peter Xu <peterx@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 David Hildenbrand <david@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Eric Farman <farman@linux.ibm.com>, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefanha@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-s390x@nongnu.org
References: <20230523163600.83391-1-philmd@linaro.org>
 <20230523163600.83391-10-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230523163600.83391-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 5/23/23 09:35, Philippe Mathieu-Daudé wrote:
> None of these files use the VirtIO Load/Store API declared
> by "hw/virtio/virtio-access.h". This header probably crept
> in via copy/pasting, remove it.
> 
> Note, "virtio-access.h" is target-specific, so any file
> including it also become tainted as target-specific.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---

Acked-by: Richard Henderson <richard.henderson@linaro.org>

r~

