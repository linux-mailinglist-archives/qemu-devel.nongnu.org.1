Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4754C784200
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 15:26:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYROF-0004pf-VK; Tue, 22 Aug 2023 09:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYROD-0004nl-QP
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 09:25:45 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYROB-0003WE-D7
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 09:25:45 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-4fe1b00fce2so6779920e87.3
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 06:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692710741; x=1693315541;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nC5K3bv9q+HuheG9WZsd2p1Ux4u5f8KfFmRsp2NG0jM=;
 b=Xa+vBVlRuAAXGN2zPifTymh+mjO9zQyYaHq6z0dVyEYlkTw4JroyCEwWa7P2Be7nT9
 nf9FkqfT4sftfkQY7MocpcJwU/G8u/Z9b1mqDydlqVBYllXJ2d60RIwiGYw+NxsEJbo2
 UvQiN2Bu++TLnytWsMvWTxAMqnqZTCEMPWjv65mPTJjZkhAwyjs9oslXqb0aizgDOMnZ
 NrUOJLoD67rcIIsgTepEduyrusOXrmsTQmOCiF5hcCx9g9WFgGKQ9n2sClnZ8Q3PZvJ7
 KB2+mhb9Hy/6oex1VaX4oZb9nTAHANs8p0HgOs2eUTNI23nkCAAx0GU4SVheJiXTM5Vu
 FtCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692710741; x=1693315541;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nC5K3bv9q+HuheG9WZsd2p1Ux4u5f8KfFmRsp2NG0jM=;
 b=VpaWdeC8W851t++dCbY9+9QQZBF/CNBLFxh6NjI1B/Mf3DG857W+XewQsVUw+IzP9t
 w/nnbDrgrIgGo6tnZyFhNkIHUUOSMHwVl51Mh28PlilKUEaTCaAhYQg3I5sklVTBT0/6
 xlbiq54PzIQ0pAsrx+EcNl2MGN6YIXGEsal/wIuIK3qCtu8dwTtzRtwZft4A+tTCtsdt
 gJOEJrFZg93mKitLxZjZOkqqSA5CjZHoLoFhO4m65tLKwIJiunS+6mH0UD+79SXe6Rhg
 8CUak8JdJ3CSNSDgLN829WvmGXUGD+bS96SPtAg6f2uYIUL2Ul+W/whL+H25JHwnVfR0
 YbTw==
X-Gm-Message-State: AOJu0YzYqvm9JefLLXKCRbHDiEGg62k91EOoys/O5GJ6D7XnITbY4bn8
 2/e4r2pspQL07DCKwixQH30+yg==
X-Google-Smtp-Source: AGHT+IHwA/H6ebYxHSWHiyN8H7UNROXIQ7QBKH/IL0ZdEOtp6iuIpp5dBgnxGR6gFOYSUKoo1eDkvA==
X-Received: by 2002:a05:6512:3e9:b0:4ff:95c:e158 with SMTP id
 n9-20020a05651203e900b004ff095ce158mr5637792lfq.64.1692710741373; 
 Tue, 22 Aug 2023 06:25:41 -0700 (PDT)
Received: from [10.2.0.2] ([37.19.214.4]) by smtp.gmail.com with ESMTPSA id
 c24-20020a05600c0ad800b003fbdbd0a7desm14874966wmr.27.2023.08.22.06.25.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Aug 2023 06:25:40 -0700 (PDT)
Message-ID: <1290963e-9f63-fc70-6729-d355d247c2fd@linaro.org>
Date: Tue, 22 Aug 2023 15:25:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH V4 0/2] migration file URI
Content-Language: en-US
To: Claudio Fontana <cfontana@suse.de>,
 Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1688135108-316997-1-git-send-email-steven.sistare@oracle.com>
 <dba1e07d-6ebf-9329-7be7-4702ff5dc16d@suse.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <dba1e07d-6ebf-9329-7be7-4702ff5dc16d@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12b.google.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.767,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi Claudio,

On 22/8/23 14:00, Claudio Fontana wrote:
> Hello,
> 
> this series is all reviewed,
> 
> and is needed as a precondition for further work to improve dramatically the performance of virsh save, virsh restore
> when migrating to disk, can it be merged?

$ ./scripts/get_maintainer.pl -f migration/meson.build
Juan Quintela <quintela@redhat.com> (maintainer:Migration)
Peter Xu <peterx@redhat.com> (reviewer:Migration)
Leonardo Bras <leobras@redhat.com> (reviewer:Migration)
qemu-devel@nongnu.org (open list:All patches CC here)

One maintainer, one single point of failure. When the
maintainer is busy or offline (vacations?) then everybody
is stuck.

This is usually solved by adding co-maintainers.

Juan, would you accept having co-maintainers helping you
dealing with the merge process? I'm not volunteering, but
this can be a good opportunity to make a formal request to
the community.

Regards,

Phil.

