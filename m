Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 790EA73F4D1
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 08:51:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE2Xg-0007xf-HG; Tue, 27 Jun 2023 02:51:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qE2Xd-0007wr-DF
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 02:51:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qE2Xb-0002P3-ES
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 02:51:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687848666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8esWfM1EaffvtAcKYoSgMPRWQGQ589HABPWbkZrMFT8=;
 b=W3KjCkQ+QFLX6AHTD7TKQyiugm26oYVfr97HhG8sAwLL028XEJedPAx5T1qHje5gATd7k3
 UmcOJ8CHH5H6rz2MzMhMlAbWLiZTJer6CpqaI5SmiyvAEFSljlqEPh5mEns/N759i63nl1
 WdY/S+gzWeScOM5PcBtoNzVERZg2bgA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-XL9sn-ujOTiRMkUKVrKe8g-1; Tue, 27 Jun 2023 02:51:04 -0400
X-MC-Unique: XL9sn-ujOTiRMkUKVrKe8g-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-635dba99f82so27684786d6.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 23:51:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687848664; x=1690440664;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8esWfM1EaffvtAcKYoSgMPRWQGQ589HABPWbkZrMFT8=;
 b=g+9kCjPr4UfHqikgEcsKXJwR9CXw5U29aBuywVXvCCEdm9Kz/dzqGcUofMciRhMY3y
 CDYLbOGvMWLyti3DFtfxU2uDuGYJjJTB/aj8+DBDZsbjTW1VXi/Hbmn4pfokls1vM4xX
 feFj/5jAVM4gV/3wTCAFTHaEoHByCcH42R2MR9v7e7hGWuoaY8E2H2Qje6ulUuA6LESq
 66H0W+B/fOXJlKRquOorLP2XcDEzDGsKbc0ps3HOhdC4G7iyBovdj48EV1hRjuy2IFSu
 I5V8+J17tJtHyDpxI+onXThvR4pU+bDV+1KSSQ41iHw41+wa2j/5bm6Xs5BKSgeR0c+2
 uyOQ==
X-Gm-Message-State: AC+VfDyDOm2huf1HGiPYGsD0qRpM90yOr4QoLPip+w4xFv7i/ztIaKYs
 XLacnaq0SJXCQ+P+yHVyjmiNNNSv+cwAT+pLKzuUnYtM3kNT0FxkUrtVhfd3EfBvo2ND+VYjdt8
 //7scJvMZ3euoP7s=
X-Received: by 2002:a05:6214:1d0b:b0:62f:eae4:b2cd with SMTP id
 e11-20020a0562141d0b00b0062feae4b2cdmr40354978qvd.16.1687848664058; 
 Mon, 26 Jun 2023 23:51:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4PX4tSRMgw7l4NAvD44tp/8//1j3H6w2iQPREHY+YnaFP06nJBs9UvIqHmvsovFqmRpAOwZg==
X-Received: by 2002:a05:6214:1d0b:b0:62f:eae4:b2cd with SMTP id
 e11-20020a0562141d0b00b0062feae4b2cdmr40354954qvd.16.1687848663857; 
 Mon, 26 Jun 2023 23:51:03 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-179-172.web.vodafone.de.
 [109.43.179.172]) by smtp.gmail.com with ESMTPSA id
 pv16-20020ad45490000000b0063019b482f8sm4159639qvb.85.2023.06.26.23.50.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jun 2023 23:51:03 -0700 (PDT)
Message-ID: <8d6492f6-7558-b496-c8c0-54591ddae777@redhat.com>
Date: Tue, 27 Jun 2023 08:50:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 06/26] qemu-keymap: properly check return from
 xkb_keymap_mod_get_index
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alexander Bulekov <alxndr@bu.edu>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Riku Voipio <riku.voipio@iki.fi>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Bandan Das <bsd@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-arm@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>, Radoslaw Biernacki
 <rad@semihalf.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Qiuhao Li <Qiuhao.Li@outlook.com>, Laurent Vivier <lvivier@redhat.com>
References: <20230626215926.2522656-1-alex.bennee@linaro.org>
 <20230626215926.2522656-7-alex.bennee@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230626215926.2522656-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 26/06/2023 23.59, Alex Bennée wrote:
> We can return XKB_MOD_INVALID which rightly gets flagged by sanitisers
> as an overly wide shift attempt.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   qemu-keymap.c | 24 ++++++++++++++++--------
>   1 file changed, 16 insertions(+), 8 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>



