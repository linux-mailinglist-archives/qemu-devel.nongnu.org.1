Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 10127707CAF
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 11:20:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzZnW-00040z-TO; Thu, 18 May 2023 05:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pzZnV-0003zA-4K
 for qemu-devel@nongnu.org; Thu, 18 May 2023 05:19:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pzZnT-0003LM-PG
 for qemu-devel@nongnu.org; Thu, 18 May 2023 05:19:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684401583;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=oewDwbTIXvVF2eb1qRCkVuYF5jJnx1QhyTHCA9NFcvI=;
 b=dMW7RU+KCm7wcXamWBzkw656UT/ZPndcS9Nqyrv5HbMzqLf7XJ0Tgcg5pmEdZMMNdZy5qR
 DieK5a0iVmubN7duuxHgG+NLh6+Ixyjc1D6lMcXTT47i/FX5+TQnqUjB/AAczDiKPHf013
 pSAWF24cxvlK/0YifdBNwGpml8nytTk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-dF25n8HIPVqJbL8xao0ySA-1; Thu, 18 May 2023 05:19:41 -0400
X-MC-Unique: dF25n8HIPVqJbL8xao0ySA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3094b683f3dso175692f8f.1
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 02:19:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684401580; x=1686993580;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oewDwbTIXvVF2eb1qRCkVuYF5jJnx1QhyTHCA9NFcvI=;
 b=ZmCICS1oW91IIeEeUw1HMO5I3us04B9TGEp32iu+mny5KpH07DDM+I11p0rr9xhVWK
 zQ6UBTqR20Zs90vDodGC00lBr2/tVpuZa6vVfLwlEce3TeZMfpyGAbHiUtDDKEVmDXzX
 tLKhlECZqjmrcy4PFYmME4WgKjYyS8HkAhP7bF3tD78LYsDEoDUZYETMaw0AItYAGOs+
 QwA9raOXpUResbSzo7TcFcsZFKjIoolo3Lz1ng6kiq4dhhoWYLSsp+7nooNKiHGTpjdn
 VnbbVs1OXh7SjtesQQd3mdQUV97m2eZzQU9D464DXQyaSzQZvYy2rHBT7oH0r8ojXuiF
 u+Yg==
X-Gm-Message-State: AC+VfDyNYVPncdsbpw6QdHWuAh9YX2adLM6QBeiUnAw10ZbU5r7aMxWw
 H0HDWmaPXOoWXLFTGRVxAp1bA4dMiuF041gaREM4zggdseQgyF336iFhJ1OPV9wlpa8aAt45z0N
 69oxtoVab53YwT00=
X-Received: by 2002:adf:ef8e:0:b0:307:41a1:a125 with SMTP id
 d14-20020adfef8e000000b0030741a1a125mr1178375wro.12.1684401580383; 
 Thu, 18 May 2023 02:19:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4l73pL+74vtz1pz4cB/2oOb1x8FYhnjBuc1Y8bfAHTyrVow49IqChdStepmQL7r6ReiL4VXg==
X-Received: by 2002:adf:ef8e:0:b0:307:41a1:a125 with SMTP id
 d14-20020adfef8e000000b0030741a1a125mr1178361wro.12.1684401580125; 
 Thu, 18 May 2023 02:19:40 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 a16-20020adfdd10000000b00307c8d6b4a0sm1530291wrm.26.2023.05.18.02.19.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 02:19:39 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  peter.maydell@linaro.org,  Peter Xu
 <peterx@redhat.com>,  Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH 6/9] migration/xbzrle: Shuffle function order
In-Reply-To: <20230518044058.2777467-7-richard.henderson@linaro.org> (Richard
 Henderson's message of "Wed, 17 May 2023 21:40:55 -0700")
References: <20230518044058.2777467-1-richard.henderson@linaro.org>
 <20230518044058.2777467-7-richard.henderson@linaro.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Thu, 18 May 2023 11:19:38 +0200
Message-ID: <87cz2yf13p.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Richard Henderson <richard.henderson@linaro.org> wrote:
> Place the CONFIG_AVX512BW_OPT block at the top,
> which will aid function selection in the next patch.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Juan Quintela <quintela@redhat.com>

Queued.


