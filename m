Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D68167BB12C
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 07:21:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qodFx-0004p9-D5; Fri, 06 Oct 2023 01:20:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qodFs-0004ov-SE
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 01:20:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qodFr-0006CX-1d
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 01:20:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696569601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FBAxr+vnn+EP39SMj+6cW5VyDDtAVVET7Zf1SxH6FOM=;
 b=Y8NfOu3dAbpzHjuA96a4TX9g22yWQAj9Hv4hxAqQNHxNL6wG/V/PeJ6dOfoau3TfZJpDiG
 1xYCzjXnupqwktLHUkSWCZ5BQ62AIT0CclZiLMhffLE6r5qqDi0hnL+9iUqv2S/zL5qi3/
 TR7sDzFxS3BLktqMx8vV7Ls+RJu1H4k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-sIB_U1KcPeKMCNs3k1KaaA-1; Fri, 06 Oct 2023 01:19:59 -0400
X-MC-Unique: sIB_U1KcPeKMCNs3k1KaaA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3232c3df248so1142298f8f.3
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 22:19:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696569598; x=1697174398;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FBAxr+vnn+EP39SMj+6cW5VyDDtAVVET7Zf1SxH6FOM=;
 b=J3una5O4tgbdVVuZ3sFx125p0t/lfQWhYtYi9rQS5qqpkL5A2Ik6UeoxMh1qPUdXzC
 LgIgPuySEmQn6/9TXzF9Xgv72prQ6pGjpEKgDBlJ2oUyMmRn9f5/SrPqjQVhtm6YJM41
 LDMo8tTxracXQiV8AZWizrROXkGEUrxuEF/MGB+iWR3R8y6kjrHEzEbX7/4ckai6kPaI
 FAEG0xDaTpcBzANwGPadnwLHBl13CNdyU+hD1w8166sK9yfGnuiabYGiKcU/Dwj5ZAx5
 7Bi0EaXjzLOqlUEh9Jeabsoyg4nOx4cpneJzNAksxrfgIdjP2YnOg0bDUwOVAeuryAXS
 xjbg==
X-Gm-Message-State: AOJu0YzoPIsJATuoIqdreMbVtF13DOWwKANHjAgvR6RNfoGf+oyWW/IU
 Uew32GxblUgdgjRsmg/yGROCvtnQ1Q6dCxZBfTcVhQe2+rfOFR+DIeXE2JIidkZMh39fH+KcC91
 B6s38n/ubTIi306JZS2oW07g=
X-Received: by 2002:a5d:48cb:0:b0:322:707e:a9fd with SMTP id
 p11-20020a5d48cb000000b00322707ea9fdmr5916816wrs.34.1696569598352; 
 Thu, 05 Oct 2023 22:19:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7Ed8LUyePbGudgdcewZm2XVlNCkZ5RKbTH//oke4npAAMEvS65BpwRUeOV/Fz8+/i+hpQRQ==
X-Received: by 2002:a5d:48cb:0:b0:322:707e:a9fd with SMTP id
 p11-20020a5d48cb000000b00322707ea9fdmr5916809wrs.34.1696569598027; 
 Thu, 05 Oct 2023 22:19:58 -0700 (PDT)
Received: from redhat.com ([2.52.3.174]) by smtp.gmail.com with ESMTPSA id
 m8-20020a056000180800b00321773bb933sm724853wrh.77.2023.10.05.22.19.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Oct 2023 22:19:28 -0700 (PDT)
Date: Fri, 6 Oct 2023 01:19:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Damien Zammit <damien@zamaudio.com>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH qemu] timer/i8254: Fix one shot PIT mode
Message-ID: <20231006011738-mutt-send-email-mst@kernel.org>
References: <57fad6fa-c27c-b534-c644-1f96318f8972@zamaudio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57fad6fa-c27c-b534-c644-1f96318f8972@zamaudio.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Fri, Oct 06, 2023 at 02:36:52AM +0000, Damien Zammit wrote:
> >From: Michael Tokarev <mjt@tls.msk.ru>
> >26.02.2023 04:58, Damien Zammit wrote:
> >> Currently, the one-shot (mode 1) PIT expires far too quickly,
> >> due to the output being set under the wrong logic.
> >> This change fixes the one-shot PIT mode to behave similarly to mode 0.
> >> 
> >> TESTED: using the one-shot PIT mode to calibrate a local apic timer.
> >
> >Has this been forgotten, or is it not needed anymore?
> 
> This is still required but nobody uses the
> PIT one-shot mode (probably because it *is* currently broken).
> 
> Can it be merged?
> 
> Thanks,
> Damien

OK, I tagged it. thanks!


