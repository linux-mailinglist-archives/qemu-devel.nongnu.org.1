Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B21607970D3
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 10:37:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeAQm-0003Do-EV; Thu, 07 Sep 2023 04:32:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qeAQi-0003DG-Lc
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 04:32:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qeAQg-0001yE-Lu
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 04:32:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694075518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2UpfMOLlpjoUFMayzAtHou1YVP+uLvcu+laIZwIKmyc=;
 b=VJxjT2jLbWq33R+e3e+udYazWwxv/v4CkuF7OqV1Hwp/Yyb3AJ09fyyO4N4IyojvxTmkfZ
 bUj4FZSYFEFhamYL3w0lWMufG6jCzAAUO2yKge/62cIHTRPDXOJeLgzgRqQBVTy8iDH43F
 gtgWPhSyqXlPvbGjHbs1ZfG12gV2Zz0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-JkDxCgFRMPiVpMEVB-s4Tw-1; Thu, 07 Sep 2023 04:31:56 -0400
X-MC-Unique: JkDxCgFRMPiVpMEVB-s4Tw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-40298cbbcdbso4458335e9.3
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 01:31:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694075515; x=1694680315;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2UpfMOLlpjoUFMayzAtHou1YVP+uLvcu+laIZwIKmyc=;
 b=OFnHjjdOaqz7HSUjfvxmXHL1L1NaJUvsbcqTq6eyK7DDIyxZHrqqiCZU7gIWx70S64
 QUio/TwSpxySx/sUUggXL9t8vZzxqpV9uDjk2Pu8wCwI4YwhoDksLxBpIvFZATmuL2xf
 detSB/zKNApMXRiyrJ53Ia2yplFAhPV0Bj+nbApi9lcMCH0xwtZH9TLgCGYyL2NFBNPs
 +PYKmslugksy//FvK6Zl+u7FydpJO9hp5IgUcsbNv/RvpG3hoNxDPt1z16XrVarsWLBz
 oVJXDcYf4/yx92N2M6lR4sSz76tfrqhMLE4IMFBmer4jwPKcLP2qyZXbU4lztOsNE1a6
 j/EA==
X-Gm-Message-State: AOJu0Yx00MY3rBJyY6uSvl98IU9AUTuAMSjLGI4mEoWL+ATupHFp0HyC
 eIhPvAQzDGiAG4uZMDtHdG2XMQfyBGZkcS50+xxO8F2RrM16G7tNaqHvfieGuqxTMSQuk3+4V0Y
 GI4/OqL752HJGPyY+p3h9usaY1A==
X-Received: by 2002:a05:600c:218b:b0:402:906:1e87 with SMTP id
 e11-20020a05600c218b00b0040209061e87mr4305063wme.31.1694075515597; 
 Thu, 07 Sep 2023 01:31:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrgPflUJWVVd1GV/WEDtouB/p3U/cTj4Fw1v62P9Dlw146TLsJbsm8s4vwrlHB8q/LOOb69A==
X-Received: by 2002:a05:600c:218b:b0:402:906:1e87 with SMTP id
 e11-20020a05600c218b00b0040209061e87mr4305046wme.31.1694075515241; 
 Thu, 07 Sep 2023 01:31:55 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-5.web.vodafone.de. [109.43.176.5])
 by smtp.gmail.com with ESMTPSA id
 t14-20020a05600c198e00b003fefcbe7fa8sm1808784wmq.28.2023.09.07.01.31.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Sep 2023 01:31:54 -0700 (PDT)
Message-ID: <2de76825-5a54-0d64-edea-27b118e3a03a@redhat.com>
Date: Thu, 7 Sep 2023 10:31:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 15/32] target/s390x: Use generic helper to show CPU
 model names
Content-Language: en-US
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
References: <20230907003553.1636896-1-gshan@redhat.com>
 <20230907003553.1636896-16-gshan@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230907003553.1636896-16-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 07/09/2023 02.35, Gavin Shan wrote:
> For target/s390x, the CPU type name is always the combination of the
> CPU modle name and suffix. The CPU model names have been correctly

s/modle/model/

  Thomas


