Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4EC7F31C6
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 15:59:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5SDE-0005JJ-8F; Tue, 21 Nov 2023 09:58:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r5SDB-0005IL-5w
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 09:58:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r5SD8-0003u4-L4
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 09:58:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700578725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RerJgdOrzorlW1VOI9VsWdsDBVd7zqQT2kYSzij5YCo=;
 b=PeaWBd3wR5pPd4I7xeoyIBlPopCSyZUsfT0rHC/Wkhi5NNUInnBoT5PcJ3bWtlDRnXR6w+
 EYtBM41Sv9TeI+Yxm/GQ/G/sYW5po2xSKrGpLJ8yBx9GnTPs39IUepe+ucB+rAB1DPbRyw
 QnyMCru4cIlArO8LBNvGe5TRigwCLuE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-NCMnuitFMue97Rcf8Et73A-1; Tue, 21 Nov 2023 09:58:43 -0500
X-MC-Unique: NCMnuitFMue97Rcf8Et73A-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-66fd88c39f6so14808296d6.0
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 06:58:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700578723; x=1701183523;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RerJgdOrzorlW1VOI9VsWdsDBVd7zqQT2kYSzij5YCo=;
 b=X2duuzSVH4WDklYxZAs1Z/em86gw9qjLlTCEM5xmNA3QDaV5rChhUjm9Fb3tcJfg3W
 5vP5/hQKkrwsxzia/3S67QwfBh5qOY0lIhMVxFu32+mKYcq8Y+kSK8xLOlIw2lg4jOCS
 qyGDpOs50wWK1GzTt+eafGtaQ/mJxN4CyoDZ4X/N/2Unil8NJyZyxwcSn1e7FMS3nMKO
 ljQFGYO5okRxSftkf1VPmkSa/bH2xTkLnOgjCfshHTaa9XuH4DNS+f52IOC9cIucqnNj
 InbiOtyq13TzWOJKsdGzS1fsHiAwXJcSWn+nz2g44yl1QEmrt2N3xHmYROaYD37BtJp6
 b4DA==
X-Gm-Message-State: AOJu0Yy8uQAj4mTKU3tyMLZ7/kDpLj/GDVvRW25rqEroQKnr3gV3eflP
 uTwmkI8l8MAg0/zwQ8fmsz1fQF1Mbb2+KuWZ7QmTmfd0IuNHd+qiX32ZWw7FvwUMu2Bvm5hGsH5
 oEPtSMbZBT/el10Q=
X-Received: by 2002:a0c:e704:0:b0:679:da0f:538d with SMTP id
 d4-20020a0ce704000000b00679da0f538dmr6450193qvn.5.1700578723054; 
 Tue, 21 Nov 2023 06:58:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFBhetBOfcURBSJxgKajykvsBKLHO22uOJo1TJn4My4ut2Kzy3RKgIUUc+pcB1TJWuFEphhhA==
X-Received: by 2002:a0c:e704:0:b0:679:da0f:538d with SMTP id
 d4-20020a0ce704000000b00679da0f538dmr6450174qvn.5.1700578722837; 
 Tue, 21 Nov 2023 06:58:42 -0800 (PST)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 n8-20020a0cee68000000b0065afbb39b2dsm4036246qvs.47.2023.11.21.06.58.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 06:58:42 -0800 (PST)
Date: Tue, 21 Nov 2023 09:58:40 -0500
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH-for-9.0 06/25] memory: Have memory_region_init_ram()
 handler return a boolean
Message-ID: <ZVzFoFp8J6TJ1aeJ@x1n>
References: <20231120213301.24349-1-philmd@linaro.org>
 <20231120213301.24349-7-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231120213301.24349-7-philmd@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Nov 20, 2023 at 10:32:40PM +0100, Philippe Mathieu-Daudé wrote:
> Following the example documented since commit e3fe3988d7 ("error:
> Document Error API usage rules"), have cpu_exec_realizefn()

(same)

> return a boolean indicating whether an error is set or not.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


