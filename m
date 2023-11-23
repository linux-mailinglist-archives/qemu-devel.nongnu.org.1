Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D71D87F6912
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 23:41:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6IMU-0001oR-Ek; Thu, 23 Nov 2023 17:39:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r6IMR-0001nm-LJ
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 17:39:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r6IM8-0006Is-O8
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 17:39:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700779170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dmwHr6/C5QDD8ZYfaEkWEun/AVZVnYqbqsc7iEYfpDY=;
 b=CK2COHZ/JzzGSokPtfaOcgjaKGGJtN0mJC/2lFXeQFXvr2anBzbUsJ8KxwuDKDPDKOuzSl
 EfwaXdZkviMZU1nX8oh/0YMpaxNLTc9QsZAKz/DkcVkLTw3yk+WisWkwl63/s2FOk5mq85
 uJeV56S4SbT7xd9mejImwueGF8IPqeY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-9rJqcHJOOQO8kRfpe2EqLw-1; Thu, 23 Nov 2023 17:39:27 -0500
X-MC-Unique: 9rJqcHJOOQO8kRfpe2EqLw-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a03337f784fso93639666b.0
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 14:39:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700779166; x=1701383966;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dmwHr6/C5QDD8ZYfaEkWEun/AVZVnYqbqsc7iEYfpDY=;
 b=v9kLnJ5KIFDQUElI1tJ0WJ6T/DnBJiIs5SXhAHa7qjS1MH6iRnjHbtExMfeEL8dVih
 i3sa7hiDW75z4rpqxntjChp4gWoMkFmvxq84e7pAHKE2oUvINd4+DyRhKAPF+WHm9BgH
 SxRd+ADunRiQDbzrvY2cIMd9jBNk+tJEn49RlO4dnIjtijcVXrah5WzN+6+ACWKoKiEV
 ezX0I8n0wXzhYtQUNPd8iYyhghRmnkHsEOLrmVL48TuZOzrzAN+gvdXpBVBE50//+3hR
 UTQ71WLSXrT2j5R2WeVPrakI2rl1j8cOJdgSZ9iRvxdF+LvNy0DW3RFEoNaBrgEgUfYF
 e4DA==
X-Gm-Message-State: AOJu0YzCVYAd2L7yiJUmZ1hEN+ywHYkatmOeHOCw4nZUwEUDpaycnD1A
 RzH49JuvaRZuCo4AYyjFJa27AzV+YzZc5jMCDdAzS6ju3JemF/cbSI8VBIUEtazJsP/PGkfmWng
 clUnbKatfv7v3Zmo=
X-Received: by 2002:aa7:d34e:0:b0:540:2c48:7913 with SMTP id
 m14-20020aa7d34e000000b005402c487913mr428867edr.38.1700779166023; 
 Thu, 23 Nov 2023 14:39:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHX8CGyribM8WsX+jl0X1ccFQmAUZdo2QbCHQVBBNFpUpggqgNKMhXUN6b0jkc/PcVrAhlX7Q==
X-Received: by 2002:aa7:d34e:0:b0:540:2c48:7913 with SMTP id
 m14-20020aa7d34e000000b005402c487913mr428854edr.38.1700779165693; 
 Thu, 23 Nov 2023 14:39:25 -0800 (PST)
Received: from redhat.com ([2.55.10.128]) by smtp.gmail.com with ESMTPSA id
 k7-20020aa7c047000000b0053de19620b9sm1093848edo.2.2023.11.23.14.39.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Nov 2023 14:39:23 -0800 (PST)
Date: Thu, 23 Nov 2023 17:39:18 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Phil =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 2/2] docs: define policy forbidding use of "AI" / LLM
 code generators
Message-ID: <20231123172828-mutt-send-email-mst@kernel.org>
References: <20231123114026.3589272-1-berrange@redhat.com>
 <20231123114026.3589272-3-berrange@redhat.com>
 <20231123092523-mutt-send-email-mst@kernel.org>
 <ZV-S1f2cK8MLNizz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZV-S1f2cK8MLNizz@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.058,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Nov 23, 2023 at 05:58:45PM +0000, Daniel P. Berrangé wrote:
> The license of a code generation tool itself is usually considered
> to be not a factor in the license of its output.

Really? I would find it very surprising if a code generation tool that
is not a language model and so is not understanding the code it's
generating did not include some code snippets going into the output.
It is also possible to unintentionally run afoul of GPL's definition of source
code which is "the preferred form of the work for making modifications to it". 
So even if you have copyright to input, dumping just output and putting
GPL on it might or might not be ok.


-- 
MST


