Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 797767B7CD1
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 12:06:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnykl-0001ai-MB; Wed, 04 Oct 2023 06:05:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnykg-0001aD-Uo
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 06:05:11 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnykf-0002KN-5F
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 06:05:10 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-9ad8bf9bfabso361660766b.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 03:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696413907; x=1697018707; darn=nongnu.org;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tyGxOIG611Gv+K/guFXbwA9OdVgkEAVezauLMqtGsGE=;
 b=E5cbIU3uak/temnLmmBR2DTPRfh+WvqKa3kucvfDw4Iz+w31Dx82IPZh8Pa0DOaqxC
 NzIfEd5j+pDBnXzhPBZh2BkiR4NRyiEW9FOU/d/vPNn0nwG7y9pdOear5aFmPtzxQzlc
 uxgMLnDnD51tWN7UhX8KTK3E+pc18Vd6NmZP0XPanTU00n2kegKpPWPDX/oumiafWBHZ
 HUI/qtBSC5sj8fjLdye+3ufY+eqxZ7gw/1S7i8VODlr0fPpxuRonooA1WHiyN5Euhyr9
 JtxqBwWnejT+vJA6m5ijyNhpdg5d2PW2PAYtRYqzvuQSJgH96flZthTGW2eQly52pXjJ
 /reQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696413907; x=1697018707;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tyGxOIG611Gv+K/guFXbwA9OdVgkEAVezauLMqtGsGE=;
 b=PKlk1EfQxSLXudZhYMhXopbMNpGR5Cowmm8FSBiX2fiNjMPeLwFoWVhCJ2ukeiLL5z
 6KgyWBK9uj2Xvh5n/FiTRxJznmgOrlfU9rlr+E2ixYtyt/B9SvRQLgXHdNgr0M8sFJIY
 ERz2lx6GTfTvQvsYlUfmJVm3hml7WjBRmeMYdiRZuPOA4IfL3UHzC645rqHPkj+u3c3Q
 NdBs/qipv0is8YQO/qOXDdNrtfW/lrh44FieWw2g9qktGdXnIaIdsmBjTDE1VqXSfs/d
 RIcXFyF1YTLfbjX7vhiNCd36pYAHAGODtJPidRtBwOTBLCTpbr1TwHCVoU9MWr+pIhTz
 3MEA==
X-Gm-Message-State: AOJu0Yzj/75PoHs7fIYH13ZNMajNkaDTs3iHHT8IN8tOlSDvd+NjdCUV
 SEB++F0pXiPc/Ed1ySkWaaDjog==
X-Google-Smtp-Source: AGHT+IF/w9xmMITeblwXgcshJv05EV7yBt8JYa2VcgRjo27GIzQW1ihFPARi1Gzt6aZR3WsEV8Abvw==
X-Received: by 2002:a17:907:2cf1:b0:9ae:513d:de22 with SMTP id
 hz17-20020a1709072cf100b009ae513dde22mr1230795ejc.56.1696413907181; 
 Wed, 04 Oct 2023 03:05:07 -0700 (PDT)
Received: from [192.168.69.115] (5ep85-h01-176-173-163-52.dslam.bbox.fr.
 [176.173.163.52]) by smtp.gmail.com with ESMTPSA id
 u6-20020a05600c00c600b004054dcbf92asm1124777wmm.20.2023.10.04.03.05.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Oct 2023 03:05:06 -0700 (PDT)
Message-ID: <14cd0201-1507-bfa8-fe9e-f482c35d21ca@linaro.org>
Date: Wed, 4 Oct 2023 12:05:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
Subject: Wshadow: Better name for 'optarg'?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi,

I'm getting a bunch of errors for 'optarg' declared in <unistd.h>:

NAME
      getopt – get option character from command line argument list

LIBRARY
      Standard C Library (libc, -lc)

SYNOPSIS
      #include <unistd.h>

      extern char *optarg;


qom/object_interfaces.c:262:53: error: declaration shadows a variable in 
the global scope [-Werror,-Wshadow]
ObjectOptions *user_creatable_parse_str(const char *optarg, Error **errp)
                                                     ^
qom/object_interfaces.c:298:46: error: declaration shadows a variable in 
the global scope [-Werror,-Wshadow]
bool user_creatable_add_from_str(const char *optarg, Error **errp)
                                              ^
qom/object_interfaces.c:313:49: error: declaration shadows a variable in 
the global scope [-Werror,-Wshadow]
void user_creatable_process_cmdline(const char *optarg)
                                                 ^
util/guest-random.c:90:45: error: declaration shadows a variable in the 
global scope [-Werror,-Wshadow]
int qemu_guest_random_seed_main(const char *optarg, Error **errp)
                                             ^
trace/control.c:288:34: error: declaration shadows a variable in the 
global scope [-Werror,-Wshadow]
void trace_opt_parse(const char *optarg)
                                  ^
/Users/philmd/source/qemu/include/qemu/plugin.h:245:54: error: 
declaration shadows a variable in the global scope [-Werror,-Wshadow]
static inline void qemu_plugin_opt_parse(const char *optarg,
                                                      ^
os-posix.c:103:31: error: declaration shadows a variable in the global 
scope [-Werror,-Wshadow]
bool os_set_runas(const char *optarg)
                               ^
os-posix.c:176:32: error: declaration shadows a variable in the global 
scope [-Werror,-Wshadow]
void os_set_chroot(const char *optarg)
                                ^
softmmu/tpm.c:178:59: error: declaration shadows a variable in the 
global scope [-Werror,-Wshadow]
int tpm_config_parse(QemuOptsList *opts_list, const char *optarg)
                                                           ^
/Users/philmd/source/qemu/include/qemu/plugin.h:245:54: error: 
declaration shadows a variable in the global scope [-Werror,-Wshadow]
static inline void qemu_plugin_opt_parse(const char *optarg,
                                                      ^
softmmu/vl.c:1069:44: error: declaration shadows a variable in the 
global scope [-Werror,-Wshadow]
static void parse_display_qapi(const char *optarg)
                                            ^
softmmu/vl.c:1224:39: error: declaration shadows a variable in the 
global scope [-Werror,-Wshadow]
static void monitor_parse(const char *optarg, const char *mode, bool pretty)
                                       ^
softmmu/vl.c:1598:17: error: declaration shadows a variable in the 
global scope [-Werror,-Wshadow]
     const char *optarg;
                 ^
softmmu/vl.c:1634:17: error: declaration shadows a variable in the 
global scope [-Werror,-Wshadow]
     const char *optarg = qdict_get_try_str(qdict, "type");
                 ^
softmmu/vl.c:1784:45: error: declaration shadows a variable in the 
global scope [-Werror,-Wshadow]
static void object_option_parse(const char *optarg)
                                             ^
softmmu/vl.c:2710:17: error: declaration shadows a variable in the 
global scope [-Werror,-Wshadow]
     const char *optarg;
                 ^
net/net.c:1680:35: error: declaration shadows a variable in the global 
scope [-Werror,-Wshadow]
bool netdev_is_modern(const char *optarg)
                                   ^
net/net.c:1714:38: error: declaration shadows a variable in the global 
scope [-Werror,-Wshadow]
void netdev_parse_modern(const char *optarg)
                                      ^
net/net.c:1728:60: error: declaration shadows a variable in the global 
scope [-Werror,-Wshadow]
void net_client_parse(QemuOptsList *opts_list, const char *optarg)
                                                            ^
semihosting/config.c:134:49: error: declaration shadows a variable in 
the global scope [-Werror,-Wshadow]
int qemu_semihosting_config_options(const char *optarg)
                                                 ^

/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/getopt.h:77:14: 
note: previous declaration is here
extern char *optarg;                    /* getopt(3) external variables */
              ^

Do we want to clean those? Any good name suggestion?

Thanks,

Phil.

